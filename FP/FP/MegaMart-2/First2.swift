//
//  First.swift
//  FP
//
//  Created by ke Liu on 6/16/25.
//

//Model
struct ShoppingCartItem: Hashable {
    let name: String
    let price: Double
}

//MVVM
var shoppingCartStore: [ShoppingCartItem] = []
var shoppingCartTotalStore: Double = 10

func addItemToCart(_ name: String, _ price: Double) {
    shoppingCartStore.append(ShoppingCartItem(name: name, price: price))
    calcCartTotal();
}

func calcCartTotal() {
    shoppingCartTotalStore = shoppingCartStore.reduce(0) { result, item in
        result + item.price
    }
}
