import XCTest
import Vapor
@testable import wkhtmltopdf

class wkhtmltopdfTests: XCTestCase {

    var app: Application!

    override func setUp() {
        super.setUp()

        app = try! Application(config: .default(), environment: .testing, services: .default())
    }

    func testStringPDF() throws {
        let req = Request(using: app)
        let document = Document(margins: 15)
        let page1 = Page("<p>Page from direct HTML</p>")
        document.pages = [page1]
        let data = try document.generatePDF(on: req).wait()
        // Cop-out test, just ensuring that the returned data is something
        XCTAssert(data.count > 50)
        // Visual test

        FileManager.default.createFile(atPath: "/tmp/vapor-wkhtmltopdf/testOutput.pdf", contents: data, attributes: nil)

        print("Test output PDF can be viewed at /tmp/vapor-wkhtmltopdf/testOutput.pdf")
    }

    static var allTests = [
        ("testStringPDF", testStringPDF),
    ]
}
