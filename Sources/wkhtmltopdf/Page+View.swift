import Vapor

extension Page {

  public init(_ drop: Droplet, view path: String, _ context: Node? = nil) throws {
    var ctx = context ?? Node.object([:])
    ctx["workDir"] = drop.config.workDir.makeNode(in: nil)
    ctx["publicDir"] = (drop.config.workDir + "Public/").makeNode(in: nil)
    let view = try drop.view.make(path, ctx)
    self.init(view.data)
  }

}
