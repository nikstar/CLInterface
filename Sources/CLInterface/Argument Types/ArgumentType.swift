import SPMUtility

public protocol ArgumentType {
    associatedtype ArgumentParserType : BaseArgumentType & ArgumentKind
}
public protocol BaseArgumentType : ArgumentType & ArgumentKind {}

extension String : BaseArgumentType {
    public typealias ArgumentParserType = Self
}
extension Int : BaseArgumentType {
    public typealias ArgumentParserType = Self
}
extension Bool : BaseArgumentType {
    public typealias ArgumentParserType = Self
}

extension Optional : ArgumentType where Wrapped : BaseArgumentType {
    public typealias ArgumentParserType = Wrapped
}

