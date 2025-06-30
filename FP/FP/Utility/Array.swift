//
//  Array.swift
//  FP
//
//  Created by ke Liu on 6/22/25.
//


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
    var newArray = array
    newArray.append(element)
    return newArray
}

func arraySet<T>(_ array: [T], _ idx: Int, _ value: T) -> [T] {
    var newArray = array
    newArray[idx] = value
    return newArray
}
