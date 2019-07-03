import Foundation
import CLInterface

final class Swiftc : CLInterface {
    var description = "Swift compiler"
    
    @Argument("--output", "-o", usage: "Write output to <file>")
    var outputPath: String?
    
    @Argument("-g", usage: "Emit debug info", default: false)
    var debugMode: Bool
    
    @Argument("--verboseness", "-v", usage: "How verbose do you want output to be?", default: 9000)
    var verboseness: Int!
    
    
    @PositionalArguments(name: "files", usage: "Files that will be compiled")
    var files: [String]
}

do {
    let swiftc = Swiftc()
    try swiftc.parseArguments(["-o", "hello", "-v", "10", "-g", "main.swift", "Greeter.swift"])
//    try swiftc.parseArguments(["-h"])
//    try swiftc.parseArguments(["--wrong"])
//    try swiftc.parseArguments([])

    print(swiftc.outputPath as Any)
    print(swiftc.debugMode!)
    print(swiftc.files)
    print(swiftc.verboseness!)
} catch {
    print(error.localizedDescription)
    exit(1)
}
