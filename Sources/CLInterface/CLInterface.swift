import SPMUtility

public protocol CLInterface {
    var description: String { get }
    var optionsString: String { get }
}

extension CLInterface {
    var optionsString: String { "[ options ]" }
}


public extension CLInterface {
    func parseArguments(_ args: [String]) {
        let argumentParser = ArgumentParser(usage: optionsString, overview: description)
        
        func setHandle<T : ArgumentKind>(ofType type: T.Type) {
            Mirror.reflectProperties(of: self, matchingType: Argument<T>.self) { arg in
                arg.handle = argumentParser.add(option: arg.longName, shortName: arg.shortName, kind: T.self, usage: arg.usage)
            }
        }
        setHandle(ofType: String.self)
        setHandle(ofType: Bool.self)
        
        let result = try! argumentParser.parse(args)
        
        func setResult<T : ArgumentKind>(ofType type: T.Type) {
            Mirror.reflectProperties(of: self, matchingType: Argument<T>.self) { argument in
                argument.parseResult = result
            }
        }
        setResult(ofType: String.self)
        setResult(ofType: Bool.self)
    }
}
