import SPMUtility

public protocol CLInterface {
    var description: String { get }
}


public extension CLInterface {
    func parseArguments(_ args: [String]) {
        let argumentParser = ArgumentParser(usage: "[ options ]", overview: description)
        
        func setHandle<T : ArgumentKind>(ofType type: T.Type) {
            Mirror.reflectProperties(of: self, matchingType: Argument<T>.self) { arg in
                arg.handle = argumentParser.add(option: arg.longName, shortName: arg.shortName, kind: T.self, usage: "DESCRIPTION", completion: nil)
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
