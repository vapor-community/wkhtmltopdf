import Bits

public struct Page {

  let content: Bytes

  public init(_ content: Bytes) {
    self.content = content
  }

  public init(_ content: String) {
    self.content = content.makeBytes()
  }

}
