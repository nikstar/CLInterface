
import CLInterface

struct Tool: CLInterface {
    var description = "This custom tool does things"
    
    @Argument("--output") var outputPath: String?
    @Argument("--verbose", "-v", default: false) var verbose: Bool
}

let tool = Tool()
//tool.parseArguments(["--output", "main.swift", "-v=true"])
tool.parseArguments(["--help"])

print(tool.outputPath as Any)
print(tool.verbose!)
