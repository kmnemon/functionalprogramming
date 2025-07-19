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

func update2<T: Indexable, R>(_ object: T, _ key1: Field, _ key2: Field, _ modify: (R)->R) -> T {
    return update(object, key1) { (value1: Indexable) in
        return update(value1, key2, modify)
    }
}
