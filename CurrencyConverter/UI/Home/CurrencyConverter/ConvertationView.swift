//
//  ConvertationView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import SwiftUI

struct CurrencyConverterView: View {
    @StateObject var viewModel: CurrencyConverterViewModel

    var body: some View {
        VStack(spacing: 16) {
            CurrencyInputView(fromCurrency: $viewModel.fromCurrency,
                                toCurrency: $viewModel.toCurrency,
                                    amount: $viewModel.fromAmount,
                                      rate: $viewModel.rate)
            swapButton
            CurrencyOutputView(fromCurrency: $viewModel.fromCurrency,
                                 toCurrency: $viewModel.toCurrency,
                                     amount: $viewModel.toAmount,
                                       rate: $viewModel.rate)
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
    let service = CurrencyService()
    let viewModel = CurrencyConverterViewModel(currencyService: service)
    CurrencyConverterView(viewModel: viewModel)
}
