//
//  HomeView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {


    var body: some View {
        NavigationView {
            VStack {
                CurrencyConverterView()
                HistoryView()
            }
            .navigationTitle("Currency Converter")
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
}
