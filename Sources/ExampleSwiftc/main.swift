import Foundation
import CLInterface

final class Swiftc : CLInterface {
    var description = "Swift compiler"
    
    @Argument("--output", "-o", usage: "Write output to <file>")
    var outputPath: String?
    
    @Argument("-g", usage: "Emit debug info", default: false)
    var debugMode: Bool
    
    @Argument("--verboseness", "-v", usage: "How verbose do you want output to be?")
    var verboseness: Int
    
    @PositionalArguments(name: "files", usage: "Files that will be compiled")
    var files: [String]
}

do {
    let swiftc = Swiftc()

    // runs successfully
//    try swiftc.parseArguments(["-o", "hello", "-v", "9000", "-g", "main.swift", "Greeter.swift"])

    // runs successfully; outputPath == nil
    try swiftc.parseArguments(["-v", "9000", "-g", "main.swift", "Greeter.swift"])

    // runs successfully; -g uses default value (false)
//    try swiftc.parseArguments(["-o", "hello", "-v", "9000", "main.swift", "Greeter.swift"])
    
    // missing --verboseness (-v); will throw an error
//    try swiftc.parseArguments(["-o", "hello", "-g", "main.swift", "Greeter.swift"])
    
//    try swiftc.parseArguments(["-h"])
//    try swiftc.parseArguments(["--wrong"])
//    try swiftc.parseArguments([])

    print(swiftc.outputPath as Any) // optional, no default
    print(swiftc.debugMode) // non-optional, default
    print(swiftc.verboseness) // non-optional, no default
    print(swiftc.files)
} catch {
    print(error.localizedDescription)
    exit(1)
}
