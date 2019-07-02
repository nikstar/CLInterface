
extension Mirror {
    static func reflectProperties<T>(
        of target: Any,
        matchingType type: T.Type = T.self,
        using closure: (T) -> Void
        ) {
        let mirror = Mirror(reflecting: target)
        
        for child in mirror.children {
            (child.value as? T).map(closure)
        }
    }
}
