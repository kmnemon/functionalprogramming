//
//  MegaMartView.swift
//  FP
//
//  Created by ke Liu on 6/16/25.
//

import SwiftUI

struct MegaMartView: View {
    @State var shoppingCart: [ShoppingCartItem] = []
    @State var shoppingCartTotal: Double = 0
    
    
    
    var body: some View {
        List {
            ForEach(shoppingCart, id: \.self) { item in
                Text("\(item.name), \(item.price)")
            }
        }
        .navigationTitle("Total Price: \(shoppingCartTotal, specifier: "%.2f")")
        .onAppear {
            self.shoppingCart = shoppingCartStore
            self.shoppingCartTotal = shoppingCartTotalStore
        }
    }
        
}
