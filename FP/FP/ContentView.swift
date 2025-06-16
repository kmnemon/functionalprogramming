//
//  ContentView.swift
//  FP
//
//  Created by ke Liu on 6/16/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationSplitView {
                List {
                    NavigationLink("Coupon Email") {
                        CouponEmailView()
                    }
                    NavigationLink("MegaMart.com") {
                        MegaMartView()
                    }
                }
            } detail: {
                Text("Select the example on the left")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
