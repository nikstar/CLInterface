import SPMUtility

@propertyDelegate
public final class PositionalArguments<T : BaseArgumentType> {
    
    public var value: [T] {
        if let handle = handle, let v = parseResult?.get(handle) {
            return v
        }
        return `default` ?? []
    }
    
    public let name: String
    public let usage: String?
    public let `default`: [T]?
    
    var handle: PositionalArgument<[T]>?
    var parseResult: ArgumentParser.Result?
    
    public init(name: String, usage: String? = nil, default: [T]? = nil) {
        self.name = name
        self.usage = usage
        self.default = `default`
    }
}

