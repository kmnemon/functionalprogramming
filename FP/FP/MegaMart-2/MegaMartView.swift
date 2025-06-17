//
//  MegaMartView.swift
//  FP
//
//  Created by ke Liu on 6/16/25.
//

import SwiftUI

struct MegaMartView: View {
    @State var shoppingCartTotal: Double = 0
    
    var body: some View {
        List {
            ForEach(shoppingList, id: \.self) { item in
                HStack {
                    Text("\(item.name): $\(item.price)")
                    Button("Buy") {
                        addItemToCart(item.name, item.price)
                        shoppingCartTotal = shoppingCartTotalStore
                    }
                    if showFreeShippingsStore[item.name] ?? false {
                        Text("Free Shipping")
                    }
                }
            }
        }
        .navigationTitle("Total Price: \(shoppingCartTotal, specifier: "%.2f")")
        .onAppear {
            self.shoppingCartTotal = shoppingCartTotalStore
        }
    }
    
}
