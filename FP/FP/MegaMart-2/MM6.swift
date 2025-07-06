//
//  First.swift
//  FP - Patterns
//         1.Straightforward implementations
//
//  Created by ke Liu on 6/16/25.
//

//Model
struct ShoppingItem: Hashable, DeepCopyable {
    var name: String
    var price: Double
    
    func deepCopy() -> ShoppingItem {
        return ShoppingItem(name: name, price: price)
    }
    
    static func == (lhs: ShoppingItem, rhs: ShoppingItem) -> Bool {
        return lhs.name == rhs.name
    }
}

class ShoppingItemRef: Equatable, DeepCopyable {
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
    
    func copy() -> ShoppingItemRef {
        return ShoppingItemRef(name: name, price: price)
    }
    
    func deepCopy() -> Self {
        return ShoppingItemRef(name: name, price: price) as! Self
    }
    
    static func == (lhs: ShoppingItemRef, rhs: ShoppingItemRef) -> Bool {
        return lhs.name == rhs.name
    }
}

let shoppingList: [ShoppingItem] = [
    ShoppingItem(name: "Apples", price: 1.99),
    ShoppingItem(name: "Milk", price: 8.49),
    ShoppingItem(name: "Bread", price: 4.79)
]

//MVVM
var shoppingCartData: [ShoppingItem] = []

var showFreeShippingsData: [String: Bool] = [:]

//0.UI handler

func addItemToCart(_ name: String, _ price: Double) -> (total: Double, tax: Double) {
    shoppingCartData = addItem(shoppingCartData, makeItem(name, price))
    
    let total = calcTotal(shoppingCartData)
    updateShipIcons(shoppingCartData)
    
    let tax = calcTax(total)
    
    shoppingCartData = blackFridayPromotionSafe(shoppingCartData)

    
    return (total, tax)
}

func deleteHandler(_ name: String) -> (total: Double, tax: Double) {
    shoppingCartData = removeItemByName(shoppingCartData, name)
    let total = calcTotal(shoppingCartData)
    updateShipIcons(shoppingCartData)
    
    let tax = calcTax(total)
    
    return (total, tax)
}

func updateShipIcons(_ cart: [ShoppingItem]) {
    for shoppingItem in shoppingList {
        let item = makeItem(shoppingItem.name, shoppingItem.price)
        let hasFreeShipping = getFreeShippingWithItem(cart, item)
        setFreeShippingIcon(shoppingItem, hasFreeShipping)
    }
}

func getFreeShippingWithItem(_ cart: [ShoppingItem], _ item: ShoppingItem) -> Bool {
    let newCart = addItem(cart, item)
    return getFreeShipping(newCart)
}

func setFreeShippingIcon(_ shoppingItem: ShoppingItem, _ isShow: Bool) {
    showFreeShippingsData[shoppingItem.name] = isShow
}

//1.bussiness rules about carts

func freeTieClip(_ cart: [ShoppingItem]) -> [ShoppingItem] {
    var hasTie = isInCart(cart, "tie")
    var hasTieClip = isInCart(cart, "tie clip")
    
    if hasTie && !hasTieClip {
        var tieClip = makeItem("tie clip", 0)
        return addItem(cart, tieClip)
    }
    
    return cart
}

fileprivate func getFreeShipping(_ cart: [ShoppingItem]) -> Bool {
    return calcTotal(cart) >= 20
}

fileprivate func blackFridayPromotionSafe(_ cart: [ShoppingItem]) -> [ShoppingItem] {
    //defensive copys
    var cartCopy = deepCopy(cart) //defensive copy as data go out to immutable zone, deep copy, copy on write
    black_friday_promotion(&cartCopy)
    return deepCopy(cartCopy) //defensive copy as data enter in immutable zone
}


//2.business rules(general)

fileprivate func calcTax(_ total: Double) -> Double {
    return total * 0.01
}

//3.basic cart operations

fileprivate func addItem(_ cart: [ShoppingItem], _ item: ShoppingItem) -> [ShoppingItem] {
    return addElementLast(cart, item)
}

func setPriceByName(_ cart: [ShoppingItem], _ name: String, _ price: Double) ->[ShoppingItem] {
    if let index = indexOfItem(cart, name) {
        return arraySet(cart, index, setPrice(cart[index], price))
    }
    return cart
}

func isInCart(_ cart: [ShoppingItem], _ name: String) -> Bool {
    return indexOfItem(cart, name) != nil
}

fileprivate func calcTotal(_ cart: [ShoppingItem]) -> Double {
    return cart.reduce(0) { total, item in
        total + item.price
    }
}

func removeItemByName(_ cart: [ShoppingItem] ,_ name: String) -> [ShoppingItem] {
    if let index = indexOfItem(cart, name) {
        return removeItems(cart, index)
    }
    
    return cart
}

//4.basic item operations

func makeItem(_ name: String, _ price: Double) -> ShoppingItem {
    return ShoppingItem(name: name, price: price)
}

func setPrice(_ item: ShoppingItem, _ price: Double) -> ShoppingItem {
    var itemCopy = item
    itemCopy.price = price
    return itemCopy
}

//5.copy-on-write operations

func addElementLast<T>(_ array: [T], _ element: T) -> [T] {
    var newArray = array
    newArray.append(element)
    return newArray
}

func removeItems<T>(_ array: [T], _ index: Array<T>.Index) ->[T] {
    var copy = array
    copy.remove(at: index)
    return copy
}

func indexOfItem<T: Equatable>(_ array: [T], _ element: T) -> Array<T>.Index? {
    for (index, value) in array.enumerated() {
        if value == element {
            return index
        }
    }
    return nil
}

func indexOfItem(_ cart: [ShoppingItem], _ name: String) -> Array.Index? {
    for (index, value) in cart.enumerated() {
        if value.name == name {
            return index
        }
    }
    return nil
}

//Legacy Code mutable

func black_friday_promotion(_ cart: inout [ShoppingItem]) {
    cart[0].price *= 0.9
}
