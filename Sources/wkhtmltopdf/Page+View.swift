import Vapor

extension Page {

  public init(_ drop: Droplet, view path: String, _ context: Node? = nil) throws {
    var ctx = context ?? Node.object([:])
    ctx["workDir"] = drop.workDir.makeNode()
    ctx["publicDir"] = (drop.workDir + "Public/").makeNode()
    let view = try drop.view.make(path, ctx)
    self.init(view.data.string)
  }

}
