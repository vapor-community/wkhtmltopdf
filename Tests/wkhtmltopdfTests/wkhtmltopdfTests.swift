import XCTest
import NIO
@testable import wkhtmltopdf

@available(macOS 12.0.0, *)
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

    func testStringPDF() async throws {
        let eventLoop = group.next()

        let document = Document(margins: 15)
        let page1 = Page("<p>Page from direct HTML</p>")
        document.pages = [page1]
        let threadPool = NIOThreadPool(numberOfThreads: 1)
        threadPool.start()
        let data = try await document.generatePDF(on: threadPool, eventLoop: eventLoop)
        try threadPool.syncShutdownGracefully()
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
