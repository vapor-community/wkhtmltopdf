import XCTest
@testable import wkhtmltopdf

class wkhtmltopdfTests: XCTestCase {
  static var allTests = [
    ("testStringPDF", testStringPDF),
  ]

  func testStringPDF() throws {
    let document = Document(margins: 15)
    let page1 = Page("<p>Page from direct HTML</p>")
    document.pages = [page1]
    _ = try document.generatePDF()
  }
}
