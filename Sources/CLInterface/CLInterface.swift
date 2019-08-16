import SPMUtility

/// `CLInterface` protocol should be implemented by a class or a struct that will represent command line interface of your program. Apart from required `description` property, it should contain `@Argument` and `@PositionalArgument` properties for any arguments you want. They will be set automatically after you call `parseArguments`.
///
/// - Example:
///
/// ```swift
/// final class Swiftc : CLInterface {
///     var description = "Swift compiler"
///
///     @Argument("--output", "-o", usage: "Write output to <file>")
///     var outputPath: String?
///
///     @Argument("-g", usage: "Emit debug info", default: false)
///     var debugMode: Bool
///
///     @PositionalArgument(name: "files", usage: "Files that will be compiled")
///     var files: [String]
/// }
/// ```
///
/// After calling `parseArguments`, you will be able to use these properties like normal variables.
public protocol CLInterface {
    var description: String { get }
    var optionsString: String { get }
}

public extension CLInterface {
    var optionsString: String { "" }
}


public extension CLInterface {
    func parseArguments(_ args: [String]? = nil) throws {
        let args = args ?? CommandLine.argumentsWithoutExecutable
        try _parseArguments(args)
    }
    
    fileprivate func _parseArguments(_ args: [String]) throws {
        let argumentParser = ArgumentParser(usage: optionsString, overview: description)
        registerArguments(argumentParser)
        let result = try argumentParser.parse(args)
        try setArgumentParserResultOnProperties(result)
    }
    
    fileprivate func registerArguments(_ argumentParser: ArgumentParser) {
        
        func setHandles<T: BaseArgumentType>(ofType: T.Type) {
            Mirror.reflectProperties(of: self, matchingType: Argument<T>.self) { arg in
                arg.register(with: argumentParser)
            }
            Mirror.reflectProperties(of: self, matchingType: Argument<Optional<T>>.self) { arg in
                arg.register(with: argumentParser)
            }
            Mirror.reflectProperties(of: self, matchingType: PositionalArgument<T>.self) { arg in
                arg.handle = argumentParser.add(positional: arg.name, kind: [T].self, optional: true, usage: arg.usage)
            }
        }
        setHandles(ofType: String.self)
        setHandles(ofType: Bool.self)
        setHandles(ofType: Int.self)
    }
    
    fileprivate func setArgumentParserResultOnProperties(_ result: ArgumentParser.Result) throws {
        
        func setResult<T: BaseArgumentType>(ofType type: T.Type) throws {
            try Mirror.reflectProperties(of: self, matchingType: Argument<T>.self) { argument in
                try argument.parseResult(result)
            }
            try Mirror.reflectProperties(of: self, matchingType: Argument<Optional<T>>.self) { argument in
                try argument.parseResult(result)
            }
            Mirror.reflectProperties(of: self, matchingType: PositionalArgument<T.Base>.self) { argument in
                argument.parseResult = result
            }
        }
        try setResult(ofType: String.self)
        try setResult(ofType: Bool.self)
        try setResult(ofType: Int.self)
    }
}
