import SPMUtility

@propertyWrapper
public final class PositionalArguments<T : BaseArgumentType> {
    
    public var wrappedValue: [T] {
        guard let handle = handle, let parseResult = parseResult else {
            fatalError("Argument parser result is unavailable. Did you call `parseArguments`?")
        }
        if let value = parseResult.get(handle) {
            return value
        }
        return `default` ?? []
    }
    
    public let name: String
    public let usage: String?
    public let `default`: [T]?
    
    var handle: PositionalArgument<[T]>?
    var parseResult: ArgumentParser.Result?
    
    /// Property wrapper representing positional arguments, e.g input files. Can be used like a normal variable after a call to `parseArguments`. Defaults to empty array.
    /// - Parameter name: Shown in `--help` menu, e.g. "files"
    /// - Parameter usage: Usage string, describing these arguments. Shown to user in `--help` menu. If omitted, it won't be shown there
    /// - Parameter default: Optional default value. If omitted, default is empty array.
    public init(name: String, usage: String? = nil, default: [T]? = nil) {
        self.name = name
        self.usage = usage
        self.default = `default`
    }
}

