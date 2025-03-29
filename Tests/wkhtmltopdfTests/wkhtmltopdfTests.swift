import Foundation
import Testing
import wkhtmltopdf

@Suite
struct wkhtmltopdfTests {
    @Test
    func testStringPDF() async throws {
        let page1 = Page("<p>Page from direct HTML</p>")
        let document = Document(pages: [page1], options: [.margins(15)], wkhtmltopdfPath: "/usr/local/bin/wkhtmltopdf")
        let data = try await document.generatePDF()

        #expect(data.count > 50)
        #expect(data[0] == 0x25)
    }

    @Test
    func testWithOptions() async throws {
        let page1 = Page(
            "<h1>Page with Background Color</h1><p>This page has custom options.</p>",
            options: [
                .background(true),
                .disableSmartShrinking,
            ])

        let page2 = Page(
            url: "https://example.com",
            options: [
                .javascriptDelay(500),
                .enableJavascript,
            ])

        let document = Document(
            pages: [page1, page2],
            options: [
                .pageSize(.letter),
                .orientation(.landscape),
                .zoom(1.5),
                .margins(10),
                .grayscale,
                .headerCenter("Header Center Text"),
                .footerCenter("Footer Center Text"),
                .footerFontSize(8),
            ]
        )

        let data = try await document.generatePDF()

        #expect(data.count > 50)
        #expect(data[0] == 0x25)
    }
}
