//
//  TabUIView.swift
//  Dual Weather iOS
//
//  Created by Brandon Lamer-Connolly on 1/26/25.
//

import SwiftUI

struct TabUIView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .navigationTitle("Top Songs")
        }
    }
}

#Preview {
    TabUIView()
}
