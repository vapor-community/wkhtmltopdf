import Foundation

public struct Page {
    let content: Data
    let options: [Option]

    public init(_ content: Data, options: [Option] = []) {
        self.content = content
        self.options = options
    }

    public init(_ content: String, options: [Option] = []) {
        self.content = Data(content.utf8)
        self.options = options
    }

    public init(url: String, options: [Option] = []) {
        self.content = Data()
        self.options = [.rawArg(url)] + options
    }

    /// If true, this page contains a URL rather than content to be written to a file
    var isUrl: Bool {
        content.isEmpty
            && options.contains {
                if case .rawArg(_) = $0 { return true }
                return false
            }
    }

    /// Get the URL if this page is a URL page
    var url: String? {
        guard isUrl else { return nil }
        for option in options {
            if case .rawArg(let url) = option {
                return url
            }
        }
        return nil
    }

    /// Convert all page options to command line arguments
    func toArguments() -> [String] {
        options.flatMap { $0.toCLIArguments() }
    }
}
