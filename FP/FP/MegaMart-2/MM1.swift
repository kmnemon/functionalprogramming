////
////  First.swift
////  FP
////
////  Created by ke Liu on 6/16/25.
////
//
//
////Model
//struct ShoppingCartItem {
//    let name: String
//    let price: Double
//}
//
//struct ShoppingListItem: Hashable {
//    let name: String
//    let price: Double
//}
//
//let shoppingList: [ShoppingListItem] = [
//    ShoppingListItem(name: "Apples", price: 1.99),
//    ShoppingListItem(name: "Milk", price: 8.49),
//    ShoppingListItem(name: "Bread", price: 4.79)
//]
//
////MVVM
//var shoppingCartData: [ShoppingCartItem] = []
//var shoppingCartTotalData: Double = 0
//
//var showFreeShippingsData: [String: Bool] = [:]
//var taxData: Double = 0
//
//func addItemToCart(_ name: String, _ price: Double) {
//    shoppingCartData.append(ShoppingCartItem(name: name, price: price))
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
