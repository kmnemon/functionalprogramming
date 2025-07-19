//
//  Untitled.swift
//  FP
//
//  Created by ke Liu on 7/18/25.
//

func update<T: Indexable, R>(_ object: T, _ key: Field, _ modify: (R)->R) -> T {
    var copy = object
    let value = copy[key] as! R
    let newValue = modify(value)
    
    let newObject = copy.setValue(for: key, value: newValue)
    return newObject
}

func update2(_ object: Indexable, _ key1: Field, _ key2: Field, _ modify: (Indexable)->Indexable) -> Indexable {
    return update(object, key1) { (value1: Indexable) in
        return update(value1, key2, modify)
    }
}

func nestedUpdate(_ object: Indexable, _ keys: [Field], _ modify: (Indexable)->Indexable) -> Indexable {
    guard !keys.isEmpty else {
        return modify(object)
    }
    
    let key1 = keys[0]
    let restKeys = Array(keys[1...])
    
    return update(object, key1) { (value1: Indexable) in
        return nestedUpdate(value1, restKeys, modify)
    }
}
