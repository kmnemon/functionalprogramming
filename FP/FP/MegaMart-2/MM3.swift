//
//  First.swift
//  FP - 1.Improving the design of actions
//          a.Aligning design with business requirements
//          b.Reducing implicit inputs and outputs
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
var shoppingCartData: [ShoppingCartItem] = []
var shoppingCartTotalData: Double = 0

var showFreeShippingsData: [String: Bool] = [:]
var taxData: Double = 0


func addItemToCart(_ name: String, _ price: Double) {
    shoppingCartData = addItem(shoppingCartData, name, price)
    shoppingCartTotalData = calcCartTotal(shoppingCartData);
}

//calculation
fileprivate func addItem(_ cart: [ShoppingCartItem], _ name: String, _ price: Double) -> [ShoppingCartItem] {
    var newCart = cart
    newCart.append(ShoppingCartItem(name: name, price: price))
    return newCart
}

func calcCartTotal(_ cart: [ShoppingCartItem]) -> Double {
    var total = calcTotal(cart)
    updateShipIcons(cart)
    updateTax(total)
    return total
}

//calculation
fileprivate func calcTotal(_ cart: [ShoppingCartItem]) -> Double {
    return cart.reduce(0) { total, item in
        total + item.price
    }
}

func updateShipIcons(_ cart: [ShoppingCartItem]) {
    for shoppingItem in shoppingList {
        let newCart = addItem(cart, shoppingItem.name, shoppingItem.price)
        showFreeShippingsData[shoppingItem.name] = getFreeShipping(newCart)
    }
}

//calculation
fileprivate func getFreeShipping(_ cart: [ShoppingCartItem]) -> Bool {
    return calcTotal(cart) >= 20
}

func updateTax(_ total: Double) {
    taxData = calcTax(total)
}

//calculation
fileprivate func calcTax(_ total: Double) -> Double {
    return total * 0.01
}
