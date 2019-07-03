
// These types will be needed to implement non-optional arguments

public protocol ArgumentType {}
public protocol BaseArgumentType : ArgumentType {}

extension String : BaseArgumentType {}
extension Int : BaseArgumentType {}
extension Bool : BaseArgumentType {}

extension Optional : ArgumentType where Wrapped : BaseArgumentType {}

