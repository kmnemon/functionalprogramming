//
//  First.swift
//  FP
//
//  Created by ke Liu on 6/16/25.
//

struct ShoppingCartItem {
    let name: String
    let price: Double
}


var shoppingCart: [ShoppingCartItem] = []
var shoppingCartTotal: Double = 0

func addItemToCart(_ name: String, _ price: Double) {
    shoppingCart.append(ShoppingCartItem(name: name, price: price))
    calcCartTotal();
}

func calcCartTotal() {
    shoppingCartTotal = shoppingCart.reduce(0) { result, item in
        result + item.price
    }
}
