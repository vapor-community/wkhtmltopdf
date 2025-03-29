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
    private var firstRawArgOption: String? {
        for  option in options {
            if case .rawArg(let arg) = option {
                return arg
            }
        }
        return nil
    }
    
    var isUrl: Bool {
        content.isEmpty && self.firstRawArgOption != nil
    }

    /// Get the URL if this page is a URL page
    var url: String? {
        content.isEmpty ? self.firstRawArgOption : nil
    }

    /// Convert all page options to command line arguments
    func toArguments() -> [String] {
        options.flatMap { $0.toCLIArguments() }
    }
}
