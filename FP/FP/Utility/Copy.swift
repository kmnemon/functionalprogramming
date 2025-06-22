//
//  Copy.swift
//  FP
//
//  Created by ke Liu on 6/22/25.
//

struct ItemValue {
    var name: String
    var price: Double
}

class ItemReference {
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
    
    func toString() -> String {
        return "\(name):\(price)"
    }
}

// not support shallow copy in value type
func deepCopy() {
    let s1: [ItemValue] = [
        ItemValue(name: "a", price: 1),
        ItemValue(name: "b", price: 2),
    ]
    
    var s2 = s1 //Copy on write, s1 and s2 is the same array, no copy
    s2[1].price = 99 //s2 copy array s1 and the nest struct, deep copy
    s2.append(ItemValue(name: "c", price: 3))

    
    print(s1) //[("a", 1), ("b", 2)]
    print(s2) //[("a", 1), ("b", 2), ("c", 3)]
    
}

func shallowCopy() {
    let s1: [ItemReference] = [
        ItemReference(name: "a", price: 1),
        ItemReference(name: "b", price: 2),
    ]
    
    var s2 = s1 //Copy on write, s1 and s2 is the same array, no copy
    s2[1].price = 99 //s2 copy array s1 and the nest class reference, shallow copy
    s2.append(ItemReference(name: "c", price: 3))

    for i in s1 {
        print(i.toString()) //[("a", 1), ("b", 99)]
    }
    
    print()
    
    for i in s2 {
        print(i.toString()) //[("a", 1), ("b", 99), ("c", 3)]
    }
}
