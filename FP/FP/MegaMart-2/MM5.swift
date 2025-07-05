////
////  First.swift
////  FP - 1.Immutability
////         a.defensive copy
////         b.wrap unsafe code
////
////  Created by ke Liu on 6/16/25.
////
//
////Model
//struct ShoppingItem: Hashable, DeepCopyable {
//    var name: String
//    var price: Double
//    
//    func deepCopy() -> ShoppingItem {
//        return ShoppingItem(name: name, price: price)
//    }
//}
//
//class ShoppingItemRef: Equatable, DeepCopyable {
//    var name: String
//    var price: Double
//    
//    init(name: String, price: Double) {
//        self.name = name
//        self.price = price
//    }
//    
//    func copy() -> ShoppingItemRef {
//        return ShoppingItemRef(name: name, price: price)
//    }
//    
//    func deepCopy() -> Self {
//        return ShoppingItemRef(name: name, price: price) as! Self
//    }
//    
//    static func == (lhs: ShoppingItemRef, rhs: ShoppingItemRef) -> Bool {
//        return lhs.name == rhs.name && lhs.price == rhs.price
//    }
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
////API
////func addItemToCart(_ name: String, _ price: Double) -> (total: Double, tax: Double)
////func deleteHandler(_ name: String) -> (total: Double, tax: Double)
//
////API - action
//func addItemToCart(_ name: String, _ price: Double) -> (total: Double, tax: Double) {
//    shoppingCartData = addItem(shoppingCartData, makeCartItem(name, price))
//    
//    let total = calcTotal(shoppingCartData)
//    updateShipIcons(shoppingCartData)
//    
//    let tax = calcTax(total)
//    
//    shoppingCartData = blackFridayPromotionSafe(shoppingCartData)
//
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
//    return getFreeShipping(newCart)
//}
//
////calculation : B
//fileprivate func getFreeShipping(_ cart: [ShoppingItem]) -> Bool {
//    return calcTotal(cart) >= 20
//}
//
////action
//func setFreeShippingIcon(_ shoppingItem: ShoppingItem, _ isShow: Bool) {
//    showFreeShippingsData[shoppingItem.name] = isShow
//}
//
////calculation : B
//fileprivate func calcTax(_ total: Double) -> Double {
//    return total * 0.01
//}
//
//fileprivate func blackFridayPromotionSafe(_ cart: [ShoppingItem]) -> [ShoppingItem] {
//    //defensive copys
//    var cartCopy = deepCopy(cart) //defensive copy as data go out to immutable zone, deep copy, copy on write
//    black_friday_promotion(&cartCopy)
//    return deepCopy(cartCopy) //defensive copy as data enter in immutable zone
//}
//
////API
//func deleteHandler(_ name: String) -> (total: Double, tax: Double) {
//    shoppingCartData = removeItemByName(shoppingCartData, name)
//    let total = calcTotal(shoppingCartData)
//    updateShipIcons(shoppingCartData)
//    
//    let tax = calcTax(total)
//    
//    return (total, tax)
//}
//
//func removeItemByName(_ cart: [ShoppingItem] ,_ name: String) -> [ShoppingItem] {
//    if let index = cart.firstIndex(where: { $0.name == name }) {
//        return removeItems(cart, index)
//    }
//    return cart
//}
//
//func setPrice(_ item: ShoppingItem, _ price: Double) -> ShoppingItem {
//    var itemCopy = item
//    itemCopy.price = price
//    return itemCopy
//}
//
//func setPriceByName(_ cart: [ShoppingItem], _ name: String, _ price: Double) ->[ShoppingItem] {
//    return cart.map {
//        if $0.name == name {
//            return setPrice($0, price)
//        } else {
//            return $0
//        }
//    }
//}
//
////Legacy Code mutable
//func black_friday_promotion(_ cart: inout [ShoppingItem]) {
//    cart[0].price *= 0.9
//}
//
//
////utility : A
//func addElementLast<T>(_ array: [T], _ element: T) -> [T] {
//    var newArray = array
//    newArray.append(element)
//    return newArray
//}
//
//func removeItems<T>(_ array: [T], _ index: Array<T>.Index) ->[T] {
//    var copy = array
//    copy.remove(at: index)
//    return copy
//}
//
//
