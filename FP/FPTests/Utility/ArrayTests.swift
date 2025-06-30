//
//  ArrayTests.swift
//  FP
//
//  Created by ke Liu on 6/29/25.
//

//Immutability Test
import Testing

let s1: [ShoppingItem] = [
    ShoppingItem(name: "Apples", price: 1.99),
    ShoppingItem(name: "Milk", price: 8.49),
    ShoppingItem(name: "Bread", price: 4.79)
]

let s1ref: [ShoppingItemRef] = [
    ShoppingItemRef(name: "Watermelon", price: 2.55),
    ShoppingItemRef(name: "Lychee", price: 4.49),
    ShoppingItemRef(name: "Peach", price: 1.79)
]

@Suite struct ValueTypeImmutableTests {
    @Test func dropFirstTest() {
        let r = dropFirst(s1)
        #expect(r.count == 2)
        #expect(s1.count == 3)
    }
    
    @Test func pushTest() {
        let r = push(s1, ShoppingItem(name: "Banana", price: 1.29))
        #expect(r.count == 4)
        #expect(s1.count == 3)
    }
    
    @Test func arraySetTest() {
        let r = arraySet(s1, 1, ShoppingItem(name: "Banana", price: 1.29))
        #expect(r[1].name == "Banana")
        #expect(s1[1].name == "Milk")
    }
    
}



@Suite struct ReferenceTypeImmutableTests {
    @Test func dropFirstTest() {
        let r = dropFirst(s1ref)
        #expect(r.count == 2)
        #expect(s1ref.count == 3)
    }
    
    @Test func pushTest() {
        let r = push(s1ref, ShoppingItemRef(name: "Banana", price: 1.29))
        #expect(r.count == 4)
        #expect(s1ref.count == 3)
    }
    
    @Test func arraySetTest() {
        let r = arraySet(s1ref, 1, ShoppingItemRef(name: "Banana", price: 1.29))
        #expect(r[1].name == "Banana")
        #expect(s1ref[1].name == "Lychee")
    }
}

