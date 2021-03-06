import SPMArgumentParser

// Argument type is one of the types that can be represented by Argument (String, Int, or Bool, optional or not)
public protocol ArgumentType {
    associatedtype Base: SPMArgumentParser.ArgumentKind & BaseArgumentType
}


// Base argument type is one of the types that can be passed as argument (String, Int, Bool)
public protocol BaseArgumentType: ArgumentType where Base == Self {}

extension String : BaseArgumentType {
    public typealias Base = Self
}
extension Int : BaseArgumentType {
    public typealias Base = Self
}
extension Bool : BaseArgumentType {
    public typealias Base = Self
}


// Optional argument type wraps Base
extension Optional: ArgumentType where Wrapped: BaseArgumentType {
    public typealias Base = Wrapped
}


// ArgumentProtocol is internal protocol to simplify work with reflection
protocol ArgumentProtocol {
    func register(with argumentParser: ArgumentParser)
    func parseResult(_ argumentParserResult: ArgumentParser.Result) throws
}
extension Argument: ArgumentProtocol { }
extension PositionalArgument: ArgumentProtocol { }
