import SPMUtility

@propertyWrapper
public final class Argument<T : ArgumentType> {
    
    public var wrappedValue: T? {
        guard let handle = handle, let parseResult = parseResult else {
            fatalError("Argument parser result is unavailable. Did you call `parseArguments`?")
        }
        if let value = parseResult.get(handle) {
            return value
        }
        return `default`
    }
    
    public let longName: String
    public let shortName: String?
    public let usage: String?
    public let `default`: T?
    
    var handle: OptionArgument<T>?
    var parseResult: ArgumentParser.Result?
    
    /// Property wrapper representing a single argument. Can be used like a normal variable after a call to `parseArguments`. Return value is always optional, but can be safely unwrapped if you provide a default value
    /// - Parameter longName: Name for your option, e.g. "--output"
    /// - Parameter shortName: Alternative short name, e.g. "-g"
    /// - Parameter usage: Usage string, describing what this argument does. Shown to user in `--help` menu. If omitted, it won't be shown there
    /// - Parameter default: Optional default value. If provided, it is safe to unwrap this property
    public init(_ longName: String, _ shortName: String? = nil, usage: String? = nil, default: T? = nil) {
        self.longName = longName
        self.shortName = shortName
        self.usage = usage
        self.default = `default`
    }
}
