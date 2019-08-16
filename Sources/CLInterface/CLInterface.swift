import SPMArgumentParser

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
        Mirror.reflectProperties(of: self, matchingType: ArgumentProtocol.self) {
            $0.register(with: argumentParser)
        }
        
        let result = try argumentParser.parse(args)
        try Mirror.reflectProperties(of: self, matchingType: ArgumentProtocol.self) {
            try $0.parseResult(result)
        }
    }
}
