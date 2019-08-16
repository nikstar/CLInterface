import protocol SPMUtility.ArgumentKind

// Argument type is on of the types that can be represented by Argument (String, Int, or Bool, optional or not)
public protocol ArgumentType {
    associatedtype Base: SPMUtility.ArgumentKind & BaseArgumentType
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
