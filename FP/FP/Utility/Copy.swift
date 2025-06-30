//
//  Copy.swift
//  FP
//
//  Created by ke Liu on 6/22/25.
//


func deepCopy<T>(_ array: [T]) -> [T] {
    return array.map(\.self)
}

