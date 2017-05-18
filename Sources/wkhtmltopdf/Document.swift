public class Document {

  // This may need changing across different platforms and deployments.
  static var zoom: String = "1.3"

  let topMargin: Int
  let rightMargin: Int
  let bottomMargin: Int
  let leftMargin: Int

  let paperSize: String

  public var pages: [Page] = []

  public init(size: String = "A4", margins all: Int? = nil, top: Int? = nil, right: Int? = nil, bottom: Int? = nil, left: Int? = nil) {
    paperSize = size
    topMargin = all ?? top ?? 20
    rightMargin = all ?? right ?? 20
    bottomMargin = all ?? bottom ?? 20
    leftMargin = all ?? left ?? 20
  }

}
