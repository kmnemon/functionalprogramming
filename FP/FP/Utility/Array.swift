//
//  Array.swift
//  FP
//
//  Created by ke Liu on 6/22/25.
//

func withArrayCopy<T>(_ array: [T], _ modify: (inout [T])->Void) -> [T] {
    var copy = array
    modify(&copy)
    return copy
}

func firstElement<T>(_ array: [T]) -> T? {
   return array.first
}

func dropFirst<T>(_ array: [T]) -> [T] {
    return Array(array.dropFirst())
}

func shift<T>(_ array: [T]) -> (T?, [T]) {
    return (array.first, dropFirst(array))
}

func lastElement<T>(_ array: [T]) -> T? {
    return array.last
}

func dropLast<T>(_ array: [T]) -> [T] {
    return Array(array.dropLast())
}

func popLast<T>(_ array: [T]) -> (T?, [T]) {
    return (array.last, dropLast(array))
}

func push<T>(_ array: [T], _ element: T) -> [T] {
    return withArrayCopy(array, { $0.append(element) })
}

func arraySet<T>(_ array: [T], _ idx: Int, _ value: T) -> [T] {
    return withArrayCopy(array, { copy in
            copy[idx] = value
    })
}


