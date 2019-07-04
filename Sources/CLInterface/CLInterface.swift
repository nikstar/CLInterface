import SPMUtility

/// `CLInterface` protocol should be implemented by a class or a struct that will represent command line interface of your program. Apart from required `description` property, it should contain `@Argument` and `@PositionalArguments` properties for any arguments you want. They will be set automatically after you call `parseArguments`.
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
///     @PositionalArguments(name: "files", usage: "Files that will be compiled")
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
    func parseArguments(_ args: [String]) throws {
        let argumentParser = ArgumentParser(usage: optionsString, overview: description)
        
        func setNonoptionalHandles<T : BaseArgumentType>(ofType type: T.Type) {
            Mirror.reflectProperties(of: self, matchingType: Argument<T>.self) { arg in
                arg.handle = argumentParser.add(option: arg.longName, shortName: arg.shortName, kind: T.ArgumentParserType.self, usage: arg.usage)
            }
            Mirror.reflectProperties(of: self, matchingType: PositionalArguments<T>.self) { arg in
                arg.handle = argumentParser.add(positional: arg.name, kind: [T].self, optional: true, usage: arg.usage)
            }
        }
        func setOptionalHandles<T : ArgumentType>(ofType type: T.Type) {
            Mirror.reflectProperties(of: self, matchingType: Argument<T>.self) { arg in
                arg.handle = argumentParser.add(option: arg.longName, shortName: arg.shortName, kind: T.ArgumentParserType.self, usage: arg.usage)
            }
        }
        setNonoptionalHandles(ofType: String.self); setOptionalHandles(ofType: Optional<String>.self)
        setNonoptionalHandles(ofType: Bool.self);   setOptionalHandles(ofType: Optional<Bool>.self)
        setNonoptionalHandles(ofType: Int.self);    setOptionalHandles(ofType: Optional<Int>.self)
        
        let result = try argumentParser.parse(args)
        
        func setResult<T : ArgumentType>(ofType type: T.Type) {
            Mirror.reflectProperties(of: self, matchingType: Argument<T>.self) { argument in
                argument.parseResult = result
            }
            Mirror.reflectProperties(of: self, matchingType: PositionalArguments<T.ArgumentParserType>.self) { argument in
                argument.parseResult = result
            }
        }
        setResult(ofType: String.self); setResult(ofType: Optional<String>.self)
        setResult(ofType: Bool.self);   setResult(ofType: Optional<Bool>.self)
        setResult(ofType: Int.self);    setResult(ofType: Optional<Int>.self)
    }
}
