//
//  Map.swift
//  FP
//
//  Created by ke on 6/23/25.
//

func mapSet<K: Hashable, V>(_ object: [K: V], _ key: K, _ value: V) -> [K: V] {
    var objectCopy = object
    objectCopy[key] = value
    return objectCopy
}
 
