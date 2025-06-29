//
//  First.swift
//  FP - 1.extracting calculation from action
//     2.eliminating all implicit inputs and outputs
//
//  Created by ke Liu on 6/16/25.
//

//Model
struct ShoppingItem: Hashable {
    let name: String
    let price: Double
}

class ShoppingItemRef {
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
    
    func copy() -> ShoppingItemRef {
        return ShoppingItemRef(name: name, price: price)
    }
}

let shoppingList: [ShoppingItem] = [
    ShoppingItem(name: "Apples", price: 1.99),
    ShoppingItem(name: "Milk", price: 8.49),
    ShoppingItem(name: "Bread", price: 4.79)
]

//MVVM
var shoppingCartData: [ShoppingItem] = []
var shoppingCartTotalData: Double = 0

var showFreeShippingsData: [String: Bool] = [:]
var taxData: Double = 0


func addItemToCart(_ name: String, _ price: Double) {
    shoppingCartData = addItem(shoppingCartData, name, price)
    calcCartTotal();
}

//calculation
fileprivate func addItem(_ cart: [ShoppingItem], _ name: String, _ price: Double) -> [ShoppingItem] {
    var newCart = cart
    newCart.append(ShoppingItem(name: name, price: price))
    return newCart
}

func calcCartTotal() {
    shoppingCartTotalData = calcTotal(shoppingCartData)
    updateShipIcons()
    updateTax()
}

//calculation
fileprivate func calcTotal(_ cart: [ShoppingItem]) -> Double {
    return cart.reduce(0) { result, item in
        result + item.price
    }
}

func updateShipIcons() {
    for shoppingItem in shoppingList {
        showFreeShippingsData[shoppingItem.name] = getFreeShipping(shoppingCartTotalData, shoppingItem.price)
    }
}

//calculation
fileprivate func getFreeShipping(_ total: Double, _ itemPrice: Double) -> Bool {
    return (total + itemPrice) >= 20
}

func updateTax() {
    taxData = calcTax(shoppingCartTotalData)
}

//calculation
fileprivate func calcTax(_ total: Double) -> Double {
    return total * 0.01
}
