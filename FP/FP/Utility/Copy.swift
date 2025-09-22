//
//  Copy.swift
//  FP
//
//  Created by ke Liu on 6/22/25.
//

protocol DeepCopyable {
    func deepCopy() -> Self
}

// 2. Extend basic value types
extension Int: DeepCopyable {
    func deepCopy() -> Self { self }
}
extension Float: DeepCopyable {
    func deepCopy() -> Self { self }
}
extension Double: DeepCopyable {
    func deepCopy() -> Self { self }
}
extension Bool: DeepCopyable {
    func deepCopy() -> Self { self }
}
extension String: DeepCopyable {
    func deepCopy() -> Self { self }
}
// Add other value types as needed (Character, etc.)

// 3. Extend collections conditionally
extension Array: DeepCopyable where Element: DeepCopyable {
    func deepCopy() -> Array {
        map { $0.deepCopy() }
    }
}

extension Dictionary: DeepCopyable where Value: DeepCopyable {
    func deepCopy() -> Dictionary {
        reduce(into: Dictionary()) { result, pair in
            result[pair.key] = pair.value.deepCopy()
        }
    }
}

extension Set: DeepCopyable where Element: DeepCopyable {
    func deepCopy() -> Set {
        Set(map { $0.deepCopy() })
    }
}

//extension Field: DeepCopyable {
//    func deepCopy() -> Self { self }
//}

// 4. Implement global deep copy function
func deepCopy<T: DeepCopyable>(_ value: T) -> T {
    value.deepCopy()
}

