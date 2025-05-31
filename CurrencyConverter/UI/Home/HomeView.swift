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

    @State private var isExpanded = false

    var body: some View {

        NavigationView {
            VStack {
                if !isExpanded {
                    CurrencyConverterView(
                        viewModel: CurrencyConverterViewModel(
                            currencyService: currencyService
                        )
                    )
                }
                HistoryView(viewModel: .init(), isExpanded: $isExpanded)
            }
            .navigationTitle(isExpanded ? "History" : "Currency Converter")
            .toolbar {
                if isExpanded {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .padding(.trailing)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
