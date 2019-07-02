import SPMUtility

@propertyDelegate
public final class Argument<T> {
    
    public var value: T? {
        if let handle = handle, let v = parseResult?.get(handle) {
            return v
        }
        return `default`
    }
    
    public let longName: String
    public let shortName: String?
    public let `default`: T?
    
    var handle: OptionArgument<T>?
    var parseResult: ArgumentParser.Result?
    
    public init(_ longName: String, _ shortName: String? = nil, default: T? = nil) {
        self.longName = longName
        self.shortName = shortName
        self.default = `default`
    }
}

