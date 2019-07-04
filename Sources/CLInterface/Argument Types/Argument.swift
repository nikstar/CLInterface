import Foundation
import SPMUtility

@propertyWrapper
public final class Argument<T : ArgumentType> {
    
    public var wrappedValue: T {
        guard let handle = handle, let parseResult = parseResult else {
            fatalError("Argument parser result is unavailable. Did you call `parseArguments`?")
        }
        if let value = parseResult.get(handle){
            return value as! T
        }
        if let `default` = `default` {
            return `default`
        }
        if isOptional {
            return Optional<T.BaseType>.none as! T
        }
        print("error: missing required argument: \(longName)")
        exit(1)
    }
    
    public let longName: String
    public let shortName: String?
    public let usage: String?
    public let `default`: T?
    
    private var isOptional: Bool { T.self == Optional<T.BaseType>.self }
    var missingRequiredArgument: Bool {
        guard let handle = handle, let parseResult = parseResult else { fatalError("Argument parser result is nil") }
        return !isOptional && parseResult.get(handle) == nil && `default` == nil
    }
    
    var handle: OptionArgument<T.BaseType>?
    var parseResult: ArgumentParser.Result?
    
    /// Property wrapper representing a single argument. Can be used like a normal variable after a call to `parseArguments`.
    /// - Parameter longName: Name for your option, e.g. "--output"
    /// - Parameter shortName: Alternative short name, e.g. "-o"
    /// - Parameter usage: Usage string, describing what this argument does. Shown to user in `--help` menu. If omitted, it won't be shown there
    /// - Parameter default: Optional default value. If provided, it is safe to unwrap this property
    public init(_ longName: String, _ shortName: String? = nil, usage: String? = nil, default: T? = nil) {
        self.longName = longName
        self.shortName = shortName
        self.usage = usage
        self.default = `default`
    }
}

