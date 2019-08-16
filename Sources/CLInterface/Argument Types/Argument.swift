import Foundation
import SPMUtility

@propertyWrapper
public final class Argument<T : ArgumentType> {
    
    enum Mode {
        case optional(default: T.Base?)
        case requiredNoDefaut
        case requiredWithDefault(default: T)
    }

    enum State {
        case notRegistered
        case registered(OptionArgument<T.Base>)
        case parsed(T)
    }
    
    public var wrappedValue: T {
        guard case .parsed(let value) = state else {
            fatalError("parseArguments was not called")
        }
        return value
    }
    
    public let longName: String
    public let shortName: String?
    public let usage: String?
    public let `default`: T.Base?
    
    fileprivate var mode: Mode
    fileprivate var state: State = .notRegistered
    
    /// Property wrapper representing a single argument. Can be used like a normal variable after a call to `parseArguments`.
    /// - Parameter longName: Name for your option, e.g. "--output"
    /// - Parameter shortName: Alternative short name, e.g. "-o"
    /// - Parameter usage: Usage string, describing what this argument does. Shown to user in `--help` menu. If omitted, it won't be shown there
    /// - Parameter default: Optional default value
    public init(_ longName: String, _ shortName: String? = nil, usage: String? = nil, default: T.Base? = nil) {
        self.longName = longName
        self.shortName = shortName
        self.usage = usage
        self.default = `default`
        
        switch (T.self == T.Base.self, `default` == nil) {
        case (true, true):
            self.mode = .requiredNoDefaut
        case (true, false):
            self.mode = .requiredWithDefault(default: `default` as! T)
        case (false, _):
            self.mode = .optional(default: `default`)
        }
    }
    
    func register(with argumentParser: ArgumentParser) {
        guard case .notRegistered = state else { fatalError("wrong state: expected notRegistered, got \(state)") }
        let handle = argumentParser.add(option: longName, shortName: shortName, kind: T.Base.self, usage: usage)
        state = .registered(handle)
    }
    
    func parseResult(_ argumentParserResult: ArgumentParser.Result) throws {
        guard case .registered(let handle) = state else { fatalError("wrong state: expected registered, got \(state)") }
        var parsedValue = argumentParserResult.get(handle)
        if parsedValue == nil {
            switch mode {
            case .optional(let `default`):
                parsedValue = `default`
            case .requiredNoDefaut:
                throw CLInterfaceError.missingRequiredArgument(name: longName)
            case .requiredWithDefault(let `default`):
                parsedValue = (`default` as! T.Base)
            }
        }
        state = .parsed(parsedValue as! T)
    }
}
