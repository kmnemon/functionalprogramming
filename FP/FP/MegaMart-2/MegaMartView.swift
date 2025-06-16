//
//  MegaMartView.swift
//  FP
//
//  Created by ke Liu on 6/16/25.
//

import SwiftUI

struct MegaMartView: View {
    @State var totalPrice: Double = 0
    
    var body: some View {
        Text("Total Price: \(totalPrice, specifier: "%.2f")")
    }
}
