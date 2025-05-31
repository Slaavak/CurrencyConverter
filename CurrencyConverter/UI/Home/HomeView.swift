//
//  HomeView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    private var currencyService = CurrencyService()

    var body: some View {
        NavigationView {
            VStack {
                CurrencyConverterView(
                    viewModel: CurrencyConverterViewModel(
                        currencyService: currencyService
                    )
                )
                HistoryView()
            }
            .navigationTitle("Currency Converter")
        }
    }
}

#Preview {
    HomeView()
}
