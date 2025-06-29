////
////  MegaMartView.swift
////  FP
////
////  Created by ke Liu on 6/16/25.
////
//
//import SwiftUI
//
//struct MegaMartView: View {
//    @State var shoppingCartTotal: Double = 0
//    @State var tax: Double = 0
//    
//    var body: some View {
//        List {
//            ForEach(shoppingList, id: \.self) { item in
//                HStack {
//                    Text("\(item.name): $\(item.price)")
//                    Button("Buy") {
//                        (shoppingCartTotal, tax) =  addItemToCart(item.name, item.price)
//                    }
//                    if showFreeShippingsData[item.name] ?? false {
//                        Text("Free Shipping")
//                    }
//                }
//            }
//        }
//        .navigationTitle("Total Price: \(shoppingCartTotal, specifier: "%.2f"), Tax: \(tax, specifier: "%.2f")")
//    }
//    
//}
