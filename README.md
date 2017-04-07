# vapor-wkhtmltopdf

![Swift](http://img.shields.io/badge/swift-3.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-1.5-brightgreen.svg)

Vapor library for converting HTML (Leaf or otherwise) into PDF files using
[wkhtmltopdf](http://wkhtmltopdf.org/).

## 📘 Overview

First, install [wkhtmltopdf](http://wkhtmltopdf.org/downloads.html). This
library is tested on version 0.12.4. Your binary should be installed at
`/usr/local/bin/wkhtmltopdf`; run it to ensure it and any dependencies are
installed correctly.

To create a PDF, create and configure a `Document`, add one or more `Page`s,
and then call `generatePDF()`. Here is a full example:

```Swift
import wkhtmltopdf

// Create document. Margins in mm, can be set individually or all at once.
// If no margins are set, the default is 20mm.
let document = Document(margins: 15)
// Create a page from an HTML string.
let page1 = Page("<p>Page from direct HTML</p>")
// Create a page from a Leaf template.
let page2 = Page(drop, view: "page_from_leaf_template")
// Create a page from a Leaf template with Context variables.
let page3 = Page(drop, view: "page_from_leaf_template", [
  "firstName": "Peter",
  "lastName": "Pan"
])
// Add the pages to the document
document.pages = [page1, page2, page3]
// Render to a PDF
let pdf = try document.generatePDF()
// Now you can return the PDF as a response, if you want
let response = Response(status: .ok, body: .data(try pdf.makeBytes()))
response.headers["Content-Type"] = "application/pdf"
return response
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

### Why Pages?

WebKit is not very good at rendering page breaks. If it works with your design,
a good alternative is to split the PDF document into separate HTML files.
`wkhtmltopdf` will combine them all and return a single PDF document.
