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
    private var dataSource = DataSource(
        container: SwiftDataContextManager.shared.container,
        context: SwiftDataContextManager.shared.context
    )

    @State private var isExpanded = false

    var body: some View {

        NavigationView {
            VStack {
                if !isExpanded {
                    CurrencyConverterView(
                        viewModel: CurrencyConverterViewModel(
                            currencyService: currencyService,
                            dataSource: dataSource
                        )
                    )
                }
                HistoryView(
                    viewModel: HistoryViewModel(dataSource: dataSource),
                   isExpanded: $isExpanded
                )
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
                                .frame(width: 20, height: 20)
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
