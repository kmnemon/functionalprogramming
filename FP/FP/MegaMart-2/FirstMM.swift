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

//MVVM
var shoppingCart: [ShoppingCartItem] = []
var shoppingCartTotalStore: Double = 0

func addItemToCart(_ name: String, _ price: Double) {
    shoppingCart.append(ShoppingCartItem(name: name, price: price))
    calcCartTotal();
}

func calcCartTotal() {
    shoppingCartTotalStore = shoppingCart.reduce(0) { result, item in
        result + item.price
    }
}
