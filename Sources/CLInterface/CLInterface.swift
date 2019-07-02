import SPMUtility

public protocol CLInterface {
    var description: String { get }
    var optionsString: String { get }
}

public extension CLInterface {
    var optionsString: String { "" }
}


public extension CLInterface {
    func parseArguments(_ args: [String]) {
        let argumentParser = ArgumentParser(usage: optionsString, overview: description)
        
        func setHandle<T : ArgumentKind>(ofType type: T.Type) {
            Mirror.reflectProperties(of: self, matchingType: Argument<T>.self) { arg in
                arg.handle = argumentParser.add(option: arg.longName, shortName: arg.shortName, kind: T.self, usage: arg.usage)
            }
            Mirror.reflectProperties(of: self, matchingType: PositionalArguments<T>.self) { arg in
                arg.handle = argumentParser.add(positional: arg.name, kind: [T].self, optional: true, usage: arg.usage)
            }
            
        }
        setHandle(ofType: String.self)
        setHandle(ofType: Bool.self)
        setHandle(ofType: Int.self)
        
        let result = try! argumentParser.parse(args)
        
        func setResult<T : ArgumentKind>(ofType type: T.Type) {
            Mirror.reflectProperties(of: self, matchingType: Argument<T>.self) { argument in
                argument.parseResult = result
            }
            Mirror.reflectProperties(of: self, matchingType: PositionalArguments<T>.self) { argument in
                argument.parseResult = result
            }
        }
        setResult(ofType: String.self)
        setResult(ofType: Bool.self)
        setHandle(ofType: Int.self)
    }
}
