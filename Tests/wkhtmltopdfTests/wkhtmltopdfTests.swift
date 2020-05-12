import XCTest
import NIO
@testable import wkhtmltopdf

class wkhtmltopdfTests: XCTestCase {

    var group: EventLoopGroup!

    override func setUp() {
        super.setUp()

        group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    }

    override func tearDown() {
        super.tearDown()

        XCTAssertNoThrow(try group.syncShutdownGracefully())
    }

    func testStringPDF() throws {
        let eventLoop = group.next()

        let document = Document(margins: 15)
        let page1 = Page("<p>Page from direct HTML</p>")
        document.pages = [page1]
        let data = try document.generatePDF(eventLoop: eventLoop).wait()
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
