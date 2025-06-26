//
//  MapTests.swift
//  FP
//
//  Created by ke Liu on 6/23/25.
//

import Testing

struct A {
    var x: Int
}

class B {
    var y: Int
    
    init(y: Int) {
        self.y = y
    }
}


@Test func mapTests() {
    var a: [A] = [
        A(x: 1)
    ]
    
    var b: [B] = [
        B(y: 1)
    ]
    
    var a1 = a
    
    a1[0].x = 9
    print(a[0].x)
    
    var b1 = b
    b1[0].y = 77
    print(b[0].y)

}
