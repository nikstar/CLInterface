import SPMUtility

public protocol ArgumentType {
    associatedtype BaseType : BaseArgumentType & ArgumentKind
}
public protocol BaseArgumentType : ArgumentType & ArgumentKind {}

extension String : BaseArgumentType {
    public typealias BaseType = Self
}
extension Int : BaseArgumentType {
    public typealias BaseType = Self
}
extension Bool : BaseArgumentType {
    public typealias BaseType = Self
}

extension Optional : ArgumentType where Wrapped : BaseArgumentType {
    public typealias BaseType = Wrapped
}

