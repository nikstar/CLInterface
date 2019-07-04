
extension Mirror {
    static func reflectProperties<T>(
        of target: Any,
        matchingType type: T.Type = T.self,
        using closure: (T) throws -> Void
        ) rethrows {
        let mirror = Mirror(reflecting: target)
        
        for child in mirror.children {
            try (child.value as? T).map(closure)
        }
    }
}
