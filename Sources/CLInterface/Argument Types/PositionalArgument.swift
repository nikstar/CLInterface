import SPMUtility

@propertyWrapper
public final class PositionalArgument<T: BaseArgumentType> {
    
    enum State {
        case notRegistered
        case registered(SPMUtility.PositionalArgument<[T]>)
        case parsed([T])
    }
    
    public var wrappedValue: [T] {
        guard case .parsed(let value) = state else {
            fatalError("parseArguments was not called")
        }
        return value
    }
    
    public let name: String
    public let usage: String?
    public let `default`: [T]
    
    fileprivate var state: State = .notRegistered
    
    /// Property wrapper representing positional arguments, e.g input files. Can be used like a normal variable after a call to `parseArguments`. Defaults to empty array.
    /// - Parameter name: Shown in `--help` menu, e.g. "files"
    /// - Parameter usage: Usage string, describing these arguments. Shown to user in `--help` menu. If omitted, it won't be shown there
    /// - Parameter default: Optional default value. If omitted, default is empty array.
    public init(name: String, usage: String? = nil, default: [T] = []) {
        self.name = name
        self.usage = usage
        self.default = `default`
    }
    
    func register(with argumentParser: ArgumentParser) {
        guard case .notRegistered = state else { fatalError("wrong state: expected notRegistered, got \(state)") }
        let handle = argumentParser.add(positional: name, kind: [T].self, optional: true, usage: usage)
        state = .registered(handle)
    }
    
    func parseResult(_ argumentParserResult: ArgumentParser.Result) {
        guard case .registered(let handle) = state else { fatalError("wrong state: expected registered, got \(state)") }
        let value = argumentParserResult.get(handle) ?? `default`
        state = .parsed(value)
    }

}

