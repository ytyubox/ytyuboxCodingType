public protocol DefaultMaker {
  static func `default`() -> Self
}
public protocol SigntonObject: AnyObject {
  static var global: Self {get set}
}

public typealias SigntonWithDefault = SigntonObject & DefaultMaker
