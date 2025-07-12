////
////  !!Not Compatible with SwiftUI!!
////
////  First.swift
////  FP - First Class
////      1.first class value
////
////  Created by ke Liu on 6/16/25.
////
//
//protocol CollectionType: DeepCopyable {}
//extension Array: CollectionType where Element: DeepCopyable {}
//extension Dictionary: CollectionType where Value: DeepCopyable {}
//
//enum FieldError: Error {
//    case invalidNumber
//}
//
//enum Field {
//    case name
//    case price
//    case quantity
//    case tax
//    case shipping
//}
//
//
//let shoppingList: [[Field: DeepCopyable]] = [
//    [Field.name: "Apples", Field.price: 1.99],
//    [Field.name: "Milk", Field.price: 8.49],
//    [Field.name: "Bread", Field.price: 4.79]
//]
//
////MVVM
//var shoppingCartData: [String: [Field: DeepCopyable]] = [:]
//
//var showFreeShippingsData: [String: Bool] = [:]
//
////0.UI handler
//
//func addItemToCart(_ name: String, _ price: Double) -> (total: Double, tax: Double) {
//    shoppingCartData = addItem(shoppingCartData as! CollectionType, makeItem(name, price)) as! [String : [Field : DeepCopyable]]
//    
//    let total = calcTotal(shoppingCartData as! CollectionType)
//    updateShipIcons(shoppingCartData as! CollectionType)
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
//    shoppingCartData = removeItemByName(shoppingCartData as! CollectionType, name) as! [String : [Field : DeepCopyable]]
//    let total = calcTotal(shoppingCartData as! CollectionType)
//    updateShipIcons(shoppingCartData as! CollectionType)
//    
//    let tax = calcTax(total)
//    
//    return (total, tax)
//}
//
//func updateShipIcons(_ cart: CollectionType) {
//    for shoppingItem in shoppingList {
//        let item = makeItem(shoppingItem[Field.name] as! String, shoppingItem[Field.price] as! Double)
//        let hasFreeShipping = getFreeShippingWithItem(cart, item)
//        setFreeShippingIcon(shoppingItem, hasFreeShipping)
//    }
//}
//
//func getFreeShippingWithItem(_ cart: CollectionType, _ item: [Field: DeepCopyable]) -> Bool {
//    let newCart = addItem(cart, item)
//    return getFreeShipping(newCart)
//}
//
//func setFreeShippingIcon(_ shoppingItem: [Field: DeepCopyable], _ isShow: Bool) {
//    showFreeShippingsData[shoppingItem[Field.name] as! String] = isShow
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
//func cartTax(_ cart: CollectionType) -> Double {
//    return calcTax(calcTotal(cart))
//}
//
//func getsWatchDiscount(_ cart: CollectionType) -> Bool {
//    let total = calcTotal(cart)
//    let hasWatch = isInCart(cart, "watch")
//    return total >= 100 && hasWatch
//}
//
//fileprivate func blackFridayPromotionSafe(_ cart: [String: [Field: DeepCopyable]]) -> [String: [Field: DeepCopyable]] {
////    //defensive copys
////    var cartCopy = deepCopy(cart) //defensive copy as data go out to immutable zone, deep copy, copy on write
////    
////    black_friday_promotion(&cartCopy)
////    
////    return deepCopy(cartCopy) //defensive copy as data enter in immutable zone
//    
//    var cartCopy: [String: [Field: DeepCopyable]] = [:]
//     for (key, item) in cart {
//         var itemCopy: [Field: DeepCopyable] = [:]
//         for (field, value) in item {
//             itemCopy[field] = value.deepCopy()
//         }
//         cartCopy[key] = itemCopy
//     }
//
//     black_friday_promotion(&cartCopy)
//
//     // Repeat deep copy on return
//     var finalCopy: [String: [Field: DeepCopyable]] = [:]
//     for (key, item) in cartCopy {
//         var itemCopy: [Field: DeepCopyable] = [:]
//         for (field, value) in item {
//             itemCopy[field] = value.deepCopy()
//         }
//         finalCopy[key] = itemCopy
//     }
//
//     return finalCopy
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
//fileprivate func addItem(_ cart: CollectionType, _ item: [Field: DeepCopyable]) -> CollectionType {
//    let dict = cart as! [String: [Field: DeepCopyable]]
//    return mapSet(dict, item[Field.name] as! String, item) as! CollectionType
//}
//
//func setFieldByName<T: DeepCopyable>(_ cart: CollectionType, _ name: String, _ field: Field, _ value: T) -> CollectionType {
//    guard isInCart(cart, name) else {
//        return cart
//    }
//    
//    let dict = cart as! [String: [Field: DeepCopyable]]
//    let item = dict[name]!
//    let newItem = mapSet(item, field, value)
//    return mapSet(dict, name, newItem) as! CollectionType
//    
//}
//
//func incrementFieldByName(_ cart: CollectionType, _ name: String, _ field: Field) throws -> CollectionType {
//    if field != .quantity {
//        throw FieldError.invalidNumber
//    }
//    
//    guard isInCart(cart, name) else {
//        return cart
//    }
//    
//    let dict = cart as! [String: [Field: DeepCopyable]]
//    let item = dict[name]!
//    let value = item[field]
//    let newValue = value as! Int + 1
//    let newItem = mapSet(item, field, newValue)
//    return mapSet(dict, name, newItem) as! CollectionType
//}
//
//func isInCart(_ cart: CollectionType, _ name: String) -> Bool {
//    let dict = cart as! [String: [Field: DeepCopyable]]
//    return dict.keys.contains(name)
//}
//
//
//fileprivate func calcTotal(_ cart: CollectionType) -> Double {
//    var total = 0.0
//    let dict = cart as! [String: [Field: DeepCopyable]]
//    for item in dict.values {
//        total += item[Field.price] as! Double
//    }
//    return total
//}
//
//
//func removeItemByName(_ cart: CollectionType ,_ name: String) -> CollectionType {
//    let dict = cart as! [String: [Field: DeepCopyable]]
//    return mapDelete(dict, name) as! CollectionType
//}
//
////4.basic item operations
//
//func makeItem(_ name: String, _ price: Double) -> [Field: DeepCopyable] {
//    return [Field.name: name, Field.price: price]
//}
//
//func setPrice(_ item: [Field: DeepCopyable], _ price: Double) -> [Field: DeepCopyable] {
//    var itemCopy = item
//    itemCopy[Field.price] = price
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
////mock DB
//func logAddToCard(_ userId: Int, _ item: [Field: DeepCopyable]) {
//    //
//}
//
////Legacy Code mutable
//
//func black_friday_promotion(_ cart: inout [String: [Field: DeepCopyable]]) {
//    cart["iwatch"]?[Field.price] = 0.9
//}
