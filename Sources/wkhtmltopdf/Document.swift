public class Document {

    let zoom: String
    let topMargin: Int
    let rightMargin: Int
    let bottomMargin: Int
    let leftMargin: Int
    let launchPath: String

    let paperSize: String
    
    /// A list of extra arguments which will be send to wkhtmltopdf directly
    ///
    ///
    /// Examples: `["--disable-smart-shrinking", "--encoding", "<encoding>"]`
    let wkArgs: [String]

    public var pages: [Page] = []
    
    public init(size: String = "A4", zoom: String? = nil, margins all: Int? = nil, top: Int? = nil, right: Int? = nil, bottom: Int? = nil, left: Int? = nil, path: String = "/usr/local/bin/wkhtmltopdf", wkArgs: [String]? = nil) {
        self.zoom = zoom ?? "1.3"
        self.paperSize = size
        self.topMargin = all ?? top ?? 20
        self.rightMargin = all ?? right ?? 20
        self.bottomMargin = all ?? bottom ?? 20
        self.leftMargin = all ?? left ?? 20
        self.launchPath = path
        
        self.wkArgs = wkArgs ?? []
    }

}
