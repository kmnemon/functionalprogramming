////
////  First.swift
////  FP - 1.Improving the design of actions
////          a.Aligning design with business requirements
////          b.Categorizing our calculations :  C: cart operation, I: Item operation, B: Business rule, A: Array utility
////          c.Separate the category P97 Chapter 5
////
////  Created by ke Liu on 6/16/25.
////
//
////Model
//struct ShoppingItem: Hashable {
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
////action
//var shoppingCartData: [ShoppingItem] = []
//
////action
//var showFreeShippingsData: [String: Bool] = [:]
//
////action
//func addItemToCart(_ name: String, _ price: Double) -> (total: Double, tax: Double) {
//    shoppingCartData = addItem(shoppingCartData, makeCartItem(name, price))
//    
//    let total = calcTotal(shoppingCartData)
//    updateShipIcons(shoppingCartData)
//    
//    let tax = calcTax(total)
//    
//    return (total, tax)
//}
//
////calculation : I
//func makeCartItem(_ name: String, _ price: Double) -> ShoppingItem {
//    return ShoppingItem(name: name, price: price)
//}
//
////Key: C: cart operation, I: Item operation, B: Business rule, A: Array utility
////calculation : C
//fileprivate func addItem(_ cart: [ShoppingItem], _ item: ShoppingItem) -> [ShoppingItem] {
//    return addElementLast(cart, item)
//}
//
////calculation : C, I, B
//fileprivate func calcTotal(_ cart: [ShoppingItem]) -> Double {
//    return cart.reduce(0) { total, item in
//        total + item.price	
//    }
//}
//
////action
//func updateShipIcons(_ cart: [ShoppingItem]) {
//    for shoppingItem in shoppingList {
//        let item = makeCartItem(shoppingItem.name, shoppingItem.price)
//        let hasFreeShipping = getFreeShippingWithItem(cart, item)
//        setFreeShippingIcon(shoppingItem, hasFreeShipping)
//    }
//}
//
////calculation :
//func getFreeShippingWithItem(_ cart: [ShoppingItem], _ item: ShoppingItem) -> Bool {
//    let newCart = addItem(cart, item)
////    return getFreeShipping(newCart)
//}
//
////action
//func setFreeShippingIcon(_ shoppingItem: ShoppingItem, _ isShow: Bool) {
//    showFreeShippingsData[shoppingItem.name] = isShow
//}
//
////calculation : B
//fileprivate func getFreeShipping(_ cart: [ShoppingItem]) -> Bool {
//    return calcTotal(cart) >= 20
//}
//
////calculation : B
//fileprivate func calcTax(_ total: Double) -> Double {
//    return total * 0.01
//}
//
//
////utility : A
//func addElementLast<T>(_ array: [T], _ element: T) -> [T] {
//    var newArray = array
//    newArray.append(element)
//    return newArray
//}
