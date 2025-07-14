//
//  Arithmetic.swift
//  FP
//
//  Created by ke Liu on 7/14/25.
//

func makeAdder(_ a: Int) -> (Int) -> Int {
    return { b in
            return a + b
    }
}

func exampleArithmetic() {
    let increment = makeAdder(1)
    print(increment(10))
    
    let plus10 = makeAdder(10)
    print(plus10(12))
}


