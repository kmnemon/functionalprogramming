//
//  First.swift
//  FP - 1.Immutability
//          a.categorize an operation as either a read or a write
//
//
//  Created by ke Liu on 6/16/25.
//

/*
 How many copy in the function with parameter cart?
 func removeItemByName(_ cart: [ShoppingCartItem] ,_ name: String) -> [ShoppingCartItem] {
     var newCart = cart
     newCart.removeAll { $0.name == name }
     return newCart
 }
 In Swift, collections like arrays are value types, which means they are copied when they are passed as arguments to functions or when they are assigned to a new variable. However, Swift uses a optimization called Copy-on-Write (CoW) to avoid unnecessary copies. The array is only actually copied when it (or a derived copy) is modified.

 Let's analyze the removeItemByName function step by step to understand how many copies are made:

 1. Initial Function Call (cart is passed by value)

 When you call removeItemByName(cart, "SomeItem"), the input array cart is passed by value.
 Due to Copy-on-Write, no actual copy is made yet because the function does not modify cart directly.
 2. Assignment to newCart (var newCart = cart)

 This creates a new variable newCart that initially shares the same buffer as cart.
 Still, no copy is made because newCart is not yet mutated.
 3. Modification (newCart.removeAll { $0.name == name })

 At this point, since newCart is being modified, Copy-on-Write triggers a real copy of the original array.
 The original cart remains unchanged, and newCart now points to a new, independent buffer where the matching items are removed.
 4. Returning newCart

 The modified newCart is returned.
 No additional copy is made here because Swift uses optimizations (like return value optimization) to avoid unnecessary copies when returning values.
 Total Copies Made: 1

 Only one real copy happens when newCart is modified (removeAll is called).
 The initial parameter passing and assignment do not cause a deep copy due to Copy-on-Write.
 Verification with Example

 You can verify this behavior by using Swift's isKnownUniquelyReferenced function (for non-@escaping contexts) or by observing memory behavior in Instruments.

 Conclusion

 Swift’s Copy-on-Write optimization ensures that only one actual copy occurs in this function—when newCart is modified. This makes array operations efficient even when working with value semantics.
 */

//Model
struct ShoppingCartItem {
    let name: String
    let price: Double
}

struct ShoppingListItem: Hashable {
    let name: String
    let price: Double
}

let shoppingList: [ShoppingListItem] = [
    ShoppingListItem(name: "Apples", price: 1.99),
    ShoppingListItem(name: "Milk", price: 8.49),
    ShoppingListItem(name: "Bread", price: 4.79)
]

//MVVM
//action
var shoppingCartData: [ShoppingCartItem] = []

//action
var showFreeShippingsData: [String: Bool] = [:]

//API
//func addItemToCart(_ name: String, _ price: Double) -> (total: Double, tax: Double)
//func deleteHandler(_ name: String) -> (total: Double, tax: Double)

//API - action
func addItemToCart(_ name: String, _ price: Double) -> (total: Double, tax: Double) {
    shoppingCartData = addItem(shoppingCartData, makeCartItem(name, price))
    
    let total = calcTotal(shoppingCartData)
    updateShipIcons(shoppingCartData)
    
    let tax = calcTax(total)
    
    return (total, tax)
}

//calculation : I
func makeCartItem(_ name: String, _ price: Double) -> ShoppingCartItem {
    return ShoppingCartItem(name: name, price: price)
}

//Key: C: cart operation, I: Item operation, B: Business rule, A: Array utility
//calculation : C
fileprivate func addItem(_ cart: [ShoppingCartItem], _ item: ShoppingCartItem) -> [ShoppingCartItem] {
    return addElementLast(cart, item)
}

//calculation : C, I, B
fileprivate func calcTotal(_ cart: [ShoppingCartItem]) -> Double {
    return cart.reduce(0) { total, item in
        total + item.price	
    }
}

//action
func updateShipIcons(_ cart: [ShoppingCartItem]) {
    for shoppingItem in shoppingList {
        let item = makeCartItem(shoppingItem.name, shoppingItem.price)
        let hasFreeShipping = getFreeShippingWithItem(cart, item)
        setFreeShippingIcon(shoppingItem, hasFreeShipping)
    }
}

//calculation :
func getFreeShippingWithItem(_ cart: [ShoppingCartItem], _ item: ShoppingCartItem) -> Bool {
    let newCart = addItem(cart, item)
    return getFreeShipping(newCart)
}

//calculation : B
fileprivate func getFreeShipping(_ cart: [ShoppingCartItem]) -> Bool {
    return calcTotal(cart) >= 20
}

//action
func setFreeShippingIcon(_ shoppingItem: ShoppingListItem, _ isShow: Bool) {
    showFreeShippingsData[shoppingItem.name] = isShow
}

//calculation : B
fileprivate func calcTax(_ total: Double) -> Double {
    return total * 0.01
}

//API
func deleteHandler(_ name: String) -> (total: Double, tax: Double) {
    shoppingCartData = removeItemByName(shoppingCartData, name)
    let total = calcTotal(shoppingCartData)
    updateShipIcons(shoppingCartData)
    
    let tax = calcTax(total)
    
    return (total, tax)
}

func removeItemByName(_ cart: [ShoppingCartItem] ,_ name: String) -> [ShoppingCartItem] {
    if let index = cart.firstIndex(where: { $0.name == name }) {
        return removeItems(cart, index)
    }
    return cart
}


//utility : A
func addElementLast<T>(_ array: [T], _ element: T) -> [T] {
    var newArray = array
    newArray.append(element)
    return newArray
}

func removeItems<T>(_ array: [T], _ index: Array<T>.Index) ->[T] {
    var copy = array
    copy.remove(at: index)
    return copy
}
