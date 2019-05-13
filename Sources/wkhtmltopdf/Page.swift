import Foundation

public struct Page {
    let content: Data

    public init(_ content: Data) {
        self.content = content
    }

    public init(_ content: String) {
        self.content = Data(content.utf8)
    }
}
