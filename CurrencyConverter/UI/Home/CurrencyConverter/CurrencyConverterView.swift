//
//  CurrencyConverterView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import SwiftUI

struct CurrencyConverterView: View {
    @StateObject var viewModel: CurrencyConverterViewModel

    var body: some View {
        VStack(spacing: 12) {
            CurrencyInputView(viewModel: viewModel)
            swapButton
            CurrencyOutputView(viewModel: viewModel)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

// MARK: - Private
private extension CurrencyConverterView {
    var swapButton: some View {
        Button(action: {
            swap(&viewModel.fromCurrency, &viewModel.toCurrency)
        }) {
            Image(systemName: "arrow.up.arrow.down")
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.blue))
                .shadow(radius: 4)
        }
    }
}

#Preview {
    let service = CurrencyService(cacheService: CurrencyCacheService())
    let dataSource = DataSource(container: previewContainer,
                                  context: previewContainer.mainContext)
    let viewModel = CurrencyConverterViewModel(currencyService: service,
                                                    dataSource: dataSource)
    CurrencyConverterView(viewModel: viewModel)
}
