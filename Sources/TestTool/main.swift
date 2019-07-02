
import CLInterface

struct Tool: CLInterface {
    var description = "This custom tool does things"
    var optionsString = ""
    
    @Argument("--output", usage: "Output path") var outputPath: String?
    @Argument("--verbose", "-v", usage: "Verbose output", default: false) var verbose: Bool
}

let tool = Tool()
//tool.parseArguments(["--output", "main.swift", "-v=true"])
tool.parseArguments(["--help"])

print(tool.outputPath as Any)
print(tool.verbose!)
