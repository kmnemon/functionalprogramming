////  First.swift
////  FP - 1.Improving the design of actions
////          a.Aligning design with business requirements
////          b.Reducing implicit inputs and outputs
//
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
//var shoppingCartData: [ShoppingItem] = []
//var showFreeShippingsData: [String: Bool] = [:]
//
//func addItemToCart(_ name: String, _ price: Double) -> (total: Double, tax: Double) {
//    shoppingCartData = addItem(shoppingCartData, name, price)
//
//    var total = calcTotal(shoppingCartData)
//    updateShipIcons(shoppingCartData)
//
//    var tax = calcTax(total)
//
//    return (total, tax)
//}
//
////Key: C: cart operation, I: Item operation, B: Business rule
////calculation : C, I
//fileprivate func addItem(_ cart: [ShoppingItem], _ name: String, _ price: Double) -> [ShoppingItem] {
//    var newCart = cart
//    newCart.append(ShoppingItem(name: name, price: price))
//    return newCart
//}
//
////calculation : C, I, B
//fileprivate func calcTotal(_ cart: [ShoppingItem]) -> Double {
//    return cart.reduce(0) { total, item in
//        total + item.price
//    }
//}
//
//func updateShipIcons(_ cart: [ShoppingItem]) {
//    for shoppingItem in shoppingList {
//        let newCart = addItem(cart, shoppingItem.name, shoppingItem.price)
//        showFreeShippingsData[shoppingItem.name] = getFreeShipping(newCart)
//    }
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
