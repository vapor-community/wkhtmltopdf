# wkhtmltopdf

![Swift](http://img.shields.io/badge/swift-5.2-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-4.0-brightgreen.svg)
![Travis](https://travis-ci.org/vapor-community/wkhtmltopdf.svg?branch=master)

Vapor 4 library for converting HTML (Leaf or otherwise) into PDF files using
[wkhtmltopdf](http://wkhtmltopdf.org/).

## Getting Started

Add the following in your `Package.swift` file
```Swift
.package(url: "https://github.com/vapor-community/wkhtmltopdf.git", from: "3.0.0"),
```

## 📘 Overview

First, install [wkhtmltopdf](http://wkhtmltopdf.org/downloads.html). This 
library is tested on version 0.12.5. Specify the location of `wkhtmltopdf` 
in the `Document` initialiser. The default is `/usr/local/bin/wkhtmltopdf`. 
Run it to ensure it and any dependencies are installed correctly.

To create a PDF, create and configure a `Document`, add one or more `Page`s,
and then call `generatePDF(on: Request)`. Here is a full example:

```Swift
import wkhtmltopdf

func pdf(_ req: Request) -> Future<Response> {
     // Create document. Margins in mm, can be set individually or all at once.
    // If no margins are set, the default is 20mm.
    let document = Document(margins: 15)
    // Create a page from an HTML string.
    let page1 = Page("<p>Page from direct HTML</p>")

    // Create a page from a Leaf template.
    let page2 = try req.view().render("page_from_leaf_template")

    // Create a page from a Leaf template with Context variables.
    let page3 = try req.view().render("page_from_leaf_template", [ "firstName": "Peter",
                                                               "lastName": "Pan"])
    let pages = [ page2, page3].flatten(on: req)
        .map { views in
            return views.map { Page($0.data) }
        }

    return pages.flatMap { pages in
        // Add the pages to the document
        document.pages = [page1] + pages
        // Render to a PDF
        let pdf = try document.generatePDF(eventLoop: req.eventLoop)
        // Now you can return the PDF as a response, if you want
        return pdf.map { data -> Response in
            return HTTPResponse(
                status: .ok,
                headers: HTTPHeaders([("Content-Type", "application/pdf")]),
                body: .init(data: data)
            )
        }
    }
}
```

In your Leaf file, you may want to load resources such as images, CSS
stylesheets and web fonts. Store these in your `Public` directory, and you can
direct `wkhtmltopdf` to this directory using the `#(publicDir)` tag.

If you'd like to use a non-public directory, you can use the `#(workDir)` tag
to render the Droplet's working directory. Of course, you can always hard-code
an absolute path instead.

Here is a worked example Leaf file which loads CSS and images. It uses the
`<base>` tag to tell `wkhtmltopdf` to look in the Public directory by default.

```HTML
<!DOCTYPE html>
<html>
  <head>
    <base href='#(publicDir)'>
    <link href='css/pdf.css' rel='stylesheet'>
  </head>
  <body>
    <img src='img/welcome.jpg'>
    <p>Welcome #(firstName) #(lastName)!</p>
  </body>
</html>
```

### Zoom calibration

Across different platforms, `wkhtmltopdf` can require different zoom levels to
ensure that 1 mm in HTML equals 1 mm in PDF. The default zoom level is `1.3`,
which has been found to work well on Linux, but if you need a different zoom
level set the static property `Document.zoom` before doing any rendering.

### Why Pages?

WebKit is not very good at rendering page breaks. If it works with your design,
a good alternative is to split the PDF document into separate HTML files.
`wkhtmltopdf` will combine them all and return a single PDF document.
