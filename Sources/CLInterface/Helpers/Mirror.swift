
extension Mirror {
    static func reflectProperties<T>(of target: Any, matchingType type: T.Type = T.self) -> [T] {
        Mirror(reflecting: target).children.compactMap { $0.value as? T }
    }
    
    @discardableResult
    static func reflectProperties<T, U>(of target: Any, matchingType type: T.Type = T.self, using closure: (T) throws -> U) rethrows -> [U] {
        try Mirror.reflectProperties(of: target, matchingType: T.self).map(closure)
    }
}
