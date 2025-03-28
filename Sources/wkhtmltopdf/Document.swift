public struct Document {
    let options: [Option]
    let launchPath: String
    let pages: [Page]

    public init(
        pages: [Page] = [],
        options: [Option] = [],
        wkhtmltopdfPath: String = "/usr/local/bin/wkhtmltopdf"
    ) {
        self.pages = pages
        self.launchPath = wkhtmltopdfPath
        self.options = options
    }

    func globalArguments() -> [String] {
        options.flatMap { $0.toCLIArguments() }
    }
}
