//
//  Lambda.swift
//  FP
//
//  Created by ke Liu on 7/15/25.
//

func forEach<T>(_ array: [T], _ f: (T) -> Void) {
    for element in array {
        f(element)
    }
}

func forEachExample() {
    let numbers: [Int] = [1, 2, 3, 4, 5]
    forEach(numbers) { print($0) }
    
    numbers.forEach { print($0) }
}

func map<T, U>(_ array: [T], _ f: (T) -> U) -> [U] {
    var newArray: [U] = []
    forEach(array) {
        newArray.append(f($0))
    }
    return newArray
}

func mapExample() {
    let numbers: [Int] = [1, 2, 3, 4, 5]
    let doubled: [Int] = map(numbers) { $0 * 2 }
    print(doubled)
    
    let anotherDoubled: [Int] = numbers.map { $0 * 2 }
    print(anotherDoubled)
}

func reduce<T, R>(_ array: [T], _ initial: R, _ f: (R, T) -> R) -> R {
    var accumulator = initial
    forEach(array) {
        accumulator = f(accumulator, $0)
    }
    return accumulator
}

func reduceExample() {
    let numbers: [Int] = [1, 2, 3, 4, 5]
    let sum: Int = reduce(numbers, 0, +)
    print(sum)
    
    let anotherSum: Int = numbers.reduce(0, +)
    print(anotherSum)
}
