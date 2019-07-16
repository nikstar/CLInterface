import Foundation

extension CommandLine {
    static var argumentsWithoutExecutable: [String] {
        Array(arguments.dropFirst())
    }
}
