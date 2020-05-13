import Foundation
import NIO

public struct Page {
    let content: Data

    public init(_ content: Data) {
        self.content = content
    }

    public init(_ content: ByteBuffer) {
        self.content = Data(content.readableBytesView)
    }

    public init(_ content: String) {
        self.content = Data(content.utf8)
    }
}
