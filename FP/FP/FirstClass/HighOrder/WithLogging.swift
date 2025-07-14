//
//  WithLogging.swift
//  FP
//
//  Created by ke Liu on 7/13/25.
//

func saveUserData(_ user: String) throws {}
func logToSnapErrors(_ error: Error) {}


//option 1: chain function with power
//Example 1:
//original
func original(_ user: String) {
    do {
        try saveUserData(user)
    } catch {
        logToSnapErrors(error)
    }
}

//chain
func withLogging( _ f: () throws -> Void) {
    do {
        try f()
    } catch {
        logToSnapErrors(error)
    }
}

func exampl1(_ user: String) {
    withLogging {
        try saveUserData(user)
    }
}

//Example 2: f(copy)
//see Array.swift - withArrayCopy

//option 2(better): high-order function, return a function with power
func wrapLogging<T>(_ f: @escaping (T) throws -> Void) -> (T) -> Void {
    return { (arg: T) in
        do {
            try f(arg)
        } catch {
            logToSnapErrors(error)
        }
    }
}

let saveUserDataWithLogging = wrapLogging(saveUserData)

func example2(_ user: String) {
    saveUserDataWithLogging(user)
}


//Example 3: f(a,b,c)
func codeDoNotThrow<T, U, V>(_ f: @escaping (T, U, V) throws -> Any) -> (T,U,V) -> Any? {
    return { (a: T, b: U, c: V) in
        do {
            return try f(a, b, c)
        } catch {
            return nil
        }
    }
}
