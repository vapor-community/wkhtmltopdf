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

    public init(size: String = "A4", zoom: String = "1.3", margins: Int = 20, path: String = "/usr/local/bin/wkhtmltopdf", wkArgs: [String] = []) {
        self.zoom = zoom
        self.paperSize = size
        self.topMargin = margins
        self.rightMargin = margins
        self.bottomMargin = margins
        self.leftMargin = margins
        self.launchPath = path
        self.wkArgs = wkArgs
    }

    public init(size: String = "A4", zoom: String = "1.3", top: Int = 20, right: Int = 20, bottom: Int = 20, left: Int = 20, path: String = "/usr/local/bin/wkhtmltopdf", wkArgs: [String] = []) {
        self.zoom = zoom
        self.paperSize = size
        self.topMargin = top
        self.rightMargin = right
        self.bottomMargin = bottom
        self.leftMargin = left
        self.launchPath = path
        self.wkArgs = wkArgs
    }
}
