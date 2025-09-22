//
//  Datastruct.swift
//  TestUI
//
//  Created by ke Liu on 9/22/25.
//

func pair<T, U>(_ a: T, _ b: U) -> ((T, U) -> Any) -> Any {
    return { select in
        return select(a, b)
    }
}

func first<T, U>(_ p: ((T, U) -> T) -> T) -> T {
    return p { a, b in a }
}

func second<T, U>(_ p: ((T, U) -> U) -> U) -> U {
    return p { a, b in b }
}
