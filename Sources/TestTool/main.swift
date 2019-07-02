
import CLInterface

struct Tool: CLInterface {
    var description = "This custom tool does things"
    var optionsString = "hello?"
    
    @Argument("--output", usage: "Output path") var outputPath: String?
    @Argument("--verbose", "-v", usage: "Verbose output", default: false) var verbose: Bool

    @PositionalArguments(name: "files", usage: "files files files")
    var files: [String]
    
}

let tool = Tool()
tool.parseArguments(["--output", "main.swift", "-v=true", "file1", "file2"])
//tool.parseArguments(["--help"])

print(tool.outputPath as Any)
print(tool.verbose)
print(tool.files)
