////
////  First.swift
////  FP - Patterns
////         1.Straightforward implementations
////         2.Abstraction barrier
////         3.Minimal interface
////  Created by ke Liu on 6/16/25.
////
//
//protocol CollectionType: DeepCopyable where Self: DeepCopyable {}
//extension Array: CollectionType where Element: DeepCopyable {}
//extension Dictionary: CollectionType where Value: DeepCopyable {}
//
////Model
//struct ShoppingItem: Hashable, DeepCopyable {
//    var name: String
//    var price: Double
//    
//    func deepCopy() -> ShoppingItem {
//        return ShoppingItem(name: name, price: price)
//    }
//    
//    static func == (lhs: ShoppingItem, rhs: ShoppingItem) -> Bool {
//        return lhs.name == rhs.name
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
//        return lhs.name == rhs.name
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
//var shoppingCartData: [String: ShoppingItem] = [:]
//
//var showFreeShippingsData: [String: Bool] = [:]
//
////0.UI handler
//
//func addItemToCart(_ name: String, _ price: Double) -> (total: Double, tax: Double) {
//    shoppingCartData = addItem(shoppingCartData, makeItem(name, price)) as! [String: ShoppingItem]
//    
//    let total = calcTotal(shoppingCartData)
//    updateShipIcons(shoppingCartData)
//    
//    let tax = calcTax(total)
//    
//    logAddToCard(1, makeItem(name, price))
//    
//    shoppingCartData = blackFridayPromotionSafe(shoppingCartData)
//    
//    
//    return (total, tax)
//}
//
//func deleteHandler(_ name: String) -> (total: Double, tax: Double) {
//    shoppingCartData = removeItemByName(shoppingCartData, name) as! [String: ShoppingItem]
//    let total = calcTotal(shoppingCartData)
//    updateShipIcons(shoppingCartData)
//    
//    let tax = calcTax(total)
//    
//    return (total, tax)
//}
//
//func updateShipIcons(_ cart: [String: ShoppingItem]) {
//    for shoppingItem in shoppingList {
//        let item = makeItem(shoppingItem.name, shoppingItem.price)
//        let hasFreeShipping = getFreeShippingWithItem(cart, item)
//        setFreeShippingIcon(shoppingItem, hasFreeShipping)
//    }
//}
//
//func getFreeShippingWithItem(_ cart: [String: ShoppingItem], _ item: ShoppingItem) -> Bool {
//    let newCart = addItem(cart, item)
//    return getFreeShipping(newCart)
//}
//
//func setFreeShippingIcon(_ shoppingItem: ShoppingItem, _ isShow: Bool) {
//    showFreeShippingsData[shoppingItem.name] = isShow
//}
//
////1.bussiness rules about carts
//
//func freeTieClip(_ cart: CollectionType) -> CollectionType {
//    let hasTie = isInCart(cart, "tie")
//    let hasTieClip = isInCart(cart, "tie clip")
//    
//    if hasTie && !hasTieClip {
//        let tieClip = makeItem("tie clip", 0)
//        return addItem(cart, tieClip)
//    }
//    
//    return cart
//}
//
//fileprivate func getFreeShipping(_ cart: CollectionType) -> Bool {
//    return calcTotal(cart) >= 20
//}
//
//func cartTax(_ cart: [ShoppingItem]) -> Double {
//    return calcTax(calcTotal(cart))
//}
//
//func getsWatchDiscount(_ cart: CollectionType) -> Bool {
//    let total = calcTotal(cart)
//    let hasWatch = isInCart(cart, "watch")
//    return total >= 100 && hasWatch
//}
//
//fileprivate func blackFridayPromotionSafe(_ cart: [String: ShoppingItem]) -> [String: ShoppingItem] {
//    //defensive copys
//    var cartCopy = deepCopy(cart) //defensive copy as data go out to immutable zone, deep copy, copy on write
//    
//    black_friday_promotion(&cartCopy)
//    return deepCopy(cartCopy) //defensive copy as data enter in immutable zone
//}
//
//
////2.business rules(general)
//
//fileprivate func calcTax(_ total: Double) -> Double {
//    return total * 0.01
//}
//
////3.basic cart operations
//
//fileprivate func addItem(_ cart: CollectionType, _ item: ShoppingItem) -> CollectionType {
//    let dict = cart as! [String: ShoppingItem]
//    return mapSet(dict, item.name, item)
//}
//
//func setPriceByName(_ cart: CollectionType, _ name: String, _ price: Double) -> CollectionType {
//    guard isInCart(cart, name) else {
//        return cart
//    }
//    
//    let dict = cart as! [String: ShoppingItem]
//    let item = dict[name]!
//    let copyItem = setPrice(item, price)
//    return mapSet(dict, item.name, copyItem)
//    
//}
//
//func isInCart(_ cart: CollectionType, _ name: String) -> Bool {
//    //    if let dict = cart as? [String: ShoppingItem] {
//    //        return dict.keys.contains(name)
//    //    }
//    //    else if let array = cart as? [ShoppingItem] {
//    //        return indexOfItem(array, name) != nil
//    //    }
//    
//    let dict = cart as! [String: ShoppingItem]
//    return dict.keys.contains(name)
//}
//
//fileprivate func calcTotal(_ cart: CollectionType) -> Double {
//    var total = 0.0
//    let dict = cart as! [String: ShoppingItem]
//    for item in dict.values {
//        total += item.price
//    }
//    return total
//}
//
//func removeItemByName(_ cart: CollectionType ,_ name: String) -> CollectionType {
//    let dict = cart as! [String: ShoppingItem]
//    return mapDelete(dict, name)
//}
//
////4.basic item operations
//
//func makeItem(_ name: String, _ price: Double) -> ShoppingItem {
//    return ShoppingItem(name: name, price: price)
//}
//
//func setPrice(_ item: ShoppingItem, _ price: Double) -> ShoppingItem {
//    var itemCopy = item
//    itemCopy.price = price
//    return itemCopy
//}
//
////5.copy-on-write operations
//
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
//func indexOfItem<T: Equatable>(_ array: [T], _ element: T) -> Array<T>.Index? {
//    for (index, value) in array.enumerated() {
//        if value == element {
//            return index
//        }
//    }
//    return nil
//}
//
//func indexOfItem(_ cart: [ShoppingItem], _ name: String) -> Array.Index? {
//    for (index, value) in cart.enumerated() {
//        if value.name == name {
//            return index
//        }
//    }
//    return nil
//}
//
////mock DB
//func logAddToCard(_ userId: Int, _ item: ShoppingItem) {
//    //
//}
//
////Legacy Code mutable
//
//func black_friday_promotion(_ cart: inout [String: ShoppingItem]) {
//    cart["iwatch"]?.price = 0.9
//}
