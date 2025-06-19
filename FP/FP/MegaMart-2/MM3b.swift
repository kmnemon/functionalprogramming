//
//  First.swift
//  FP - 1.Improving the design of actions
//          a.Aligning design with business requirements
//          b.Categorizing our calculations :  C: cart operation, I: Item operation, B: Business rule, A: Array utility
//          c.Separate the category P97 Chapter 5
//
//  Created by ke Liu on 6/16/25.
//

//Model
struct ShoppingCartItem {
    let name: String
    let price: Double
}

struct ShoppingListItem: Hashable {
    let name: String
    let price: Double
}

let shoppingList: [ShoppingListItem] = [
    ShoppingListItem(name: "Apples", price: 1.99),
    ShoppingListItem(name: "Milk", price: 8.49),
    ShoppingListItem(name: "Bread", price: 4.79)
]

//MVVM
//action
var shoppingCartData: [ShoppingCartItem] = []

//action
var showFreeShippingsData: [String: Bool] = [:]

//action
func addItemToCart(_ name: String, _ price: Double) -> (total: Double, tax: Double) {
    shoppingCartData = addItem(shoppingCartData, makeCartItem(name, price))
    
    var total = calcTotal(shoppingCartData)
    updateShipIcons(shoppingCartData)
    
    var tax = calcTax(total)
    
    return (total, tax)
}

//calculation : I
func makeCartItem(_ name: String, _ price: Double) -> ShoppingCartItem {
    return ShoppingCartItem(name: name, price: price)
}

//Key: C: cart operation, I: Item operation, B: Business rule, A: Array utility
//calculation : C
fileprivate func addItem(_ cart: [ShoppingCartItem], _ item: ShoppingCartItem) -> [ShoppingCartItem] {
    return addElementLast(cart, item)
}

//calculation : C, I, B
fileprivate func calcTotal(_ cart: [ShoppingCartItem]) -> Double {
    return cart.reduce(0) { total, item in
        total + item.price	
    }
}

//action
func updateShipIcons(_ cart: [ShoppingCartItem]) {
    for shoppingItem in shoppingList {
        let item = makeCartItem(shoppingItem.name, shoppingItem.price)
        let hasFreeShipping = getFreeShippingWithItem(cart, item)
        setFreeShippingIcon(shoppingItem, hasFreeShipping)
    }
}

//calculation :
func getFreeShippingWithItem(_ cart: [ShoppingCartItem], _ item: ShoppingCartItem) -> Bool {
    let newCart = addItem(cart, item)
    return getFreeShipping(newCart)
}

//action
func setFreeShippingIcon(_ shoppingItem: ShoppingListItem, _ isShow: Bool) {
    showFreeShippingsData[shoppingItem.name] = isShow
}

//calculation : B
fileprivate func getFreeShipping(_ cart: [ShoppingCartItem]) -> Bool {
    return calcTotal(cart) >= 20
}

//calculation : B
fileprivate func calcTax(_ total: Double) -> Double {
    return total * 0.01
}


//utility : A
func addElementLast<T>(_ array: [T], _ element: T) -> [T] {
    var newArray = array
    newArray.append(element)
    return newArray
}
