////
////  First.swift
////  FP
////
////  Created by ke Liu on 6/16/25.
////
//
//
////Model
//struct ShoppingItem {
//    let name: String
//    let price: Double
//}
//
//let shoppingList: [ShoppingItem] = [
//    ShoppingItem(name: "Apples", price: 1.99),
//    ShoppingItem(name: "Milk", price: 8.49),
//    ShoppingItem(name: "Bread", price: 4.79)
//]
//
////MVVM
//var shoppingCartData: [ShoppingItem] = []
//var shoppingCartTotalData: Double = 0
//
//var showFreeShippingsData: [String: Bool] = [:]
//var taxData: Double = 0
//
//func addItemToCart(_ name: String, _ price: Double) {
//    shoppingCartData.append(ShoppingItem(name: name, price: price))
//    calcCartTotal();
//}
//
//func calcCartTotal() {
//    shoppingCartTotalData = shoppingCartData.reduce(0) { result, item in
//        result + item.price
//    }
//    updateShipIcons()
//    updateTax()
//}
//
//func updateShipIcons() {
//    for shoppingItem in shoppingList {
//        showFreeShippingsData[shoppingItem.name] = (shoppingCartTotalData + shoppingItem.price) >= 20
//    }
//}
//
//func updateTax() {
//    taxData = shoppingCartTotalData * 0.01
//}
//
