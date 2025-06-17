//
//  First.swift
//  FP
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
var shoppingCart: [ShoppingCartItem] = []
var shoppingCartTotalStore: Double = 0
var showFreeShippingsStore: [String: Bool] = [:]

func addItemToCart(_ name: String, _ price: Double) {
    shoppingCart.append(ShoppingCartItem(name: name, price: price))
    calcCartTotal();
}

func calcCartTotal() {
    shoppingCartTotalStore = shoppingCart.reduce(0) { result, item in
        result + item.price
    }
    updateShipIcons()
}

func updateShipIcons() {
    for shoppingItem in shoppingList {
        showFreeShippingsStore[shoppingItem.name] = (shoppingCartTotalStore + shoppingItem.price) >= 20
    }
}
