//
//  Map.swift
//  FP
//
//  Created by ke on 6/23/25.
//

func withMapCopy<K: Hashable, V>(_ object: [K: V], _ modify: (inout [K: V]) -> Void) -> [K: V] {
    var copy = object
    modify(&copy)
    return copy
}

func mapSet<K: Hashable, V>(_ object: [K: V], _ key: K, _ value: V) -> [K: V] {
    return withMapCopy(object, { $0[key] = value })
}
 
func mapDelete<K: Hashable, V>(_ object: [K: V], _ key: K) -> [K: V] {
    return withMapCopy(object, { $0[key] = nil })
}
