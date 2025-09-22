//
//  Untitled.swift
//  FP
//
//  Created by ke Liu on 7/18/25.
//

func update<T: Collection, R>(_ object: T, _ key: Field, _ modify: (R)->R) -> T {
    var copy = object
    let value = copy[key] as! R
    let newValue = modify(value)
    
    let newObject = copy.setValue(for: key, value: newValue)
    return newObject
}

func update2(_ object: Collection, _ key1: Field, _ key2: Field, _ modify: (Collection)->Collection) -> Collection {
    return update(object, key1) { (value1: Collection) in
        return update(value1, key2, modify)
    }
}

func nestedUpdate(_ object: Collection, _ keys: [Field], _ modify: (Collection)->Collection) -> Collection {
    guard !keys.isEmpty else {
        return modify(object)
    }
    
    let key1 = keys[0]
    let restKeys = Array(keys[1...])
    
    return update(object, key1) { (value1: Collection) in
        return nestedUpdate(value1, restKeys, modify)
    }
}
