import SPMUtility

@propertyWrapper
public final class Argument<T : ArgumentType> {
    
    public var wrappedValue: T? {
        if let handle = handle, let v = parseResult?.get(handle) {
            return v
        }
        return `default`
    }
    
    public let longName: String
    public let shortName: String?
    public let usage: String?
    public let `default`: T?
    
    var handle: OptionArgument<T>?
    var parseResult: ArgumentParser.Result?
    
    public init(_ longName: String, _ shortName: String? = nil, usage: String? = nil, default: T? = nil) {
        self.longName = longName
        self.shortName = shortName
        self.usage = usage
        self.default = `default`
    }
}
