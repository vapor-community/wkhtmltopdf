public class Document {

    let zoom: String
    let topMargin: Int
    let rightMargin: Int
    let bottomMargin: Int
    let leftMargin: Int

    let paperSize: String

    public var pages: [Page] = []
    
    public init(size: String = "A4", zoom: String? = nil, margins all: Int? = nil, top: Int? = nil, right: Int? = nil, bottom: Int? = nil, left: Int? = nil) {
        self.zoom = zoom ?? "1.3"
        paperSize = size
        topMargin = all ?? top ?? 20
        rightMargin = all ?? right ?? 20
        bottomMargin = all ?? bottom ?? 20
        leftMargin = all ?? left ?? 20
    }

}
