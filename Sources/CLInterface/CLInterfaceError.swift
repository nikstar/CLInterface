import Foundation

public enum CLInterfaceError: Swift.Error {
    
    /// Missing required argument without default value.
    case missingRequiredArgument(name: String)
}

extension CLInterfaceError: LocalizedError {
    public var errorDescription: String? {
        return description
    }
}

extension CLInterfaceError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .missingRequiredArgument(let name):
            return "missing required argument \(name); use --help to print usage"
        }
    }
}

