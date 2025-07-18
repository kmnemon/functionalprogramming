//
//  Untitled.swift
//  FP
//
//  Created by ke Liu on 7/18/25.
//

func update<T: Indexable, R>(_ object: inout T, _ key: Field, _ modify: (R)->R) -> T {
    let value = object[key] as! R
    let newValue = modify(value)
    
    let newObject = object.setValue(for: key, value: newValue)
    return newObject
}
