//
//  ConvertationView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import SwiftUI

struct CurrencyConverterView: View {
    @StateObject var viewModel: CurrencyConverterViewModel


    var toAmount: String {
        let value = Double(viewModel.fromAmount) ?? 0
        let result = value * (viewModel.rate ?? 0.0)
        return String(format: "%.2f", result)
    }

    var body: some View {
        VStack(spacing:16) {
            CurrencyInputView(currency: $viewModel.fromCurrency,
                                amount: $viewModel.fromAmount,
                                  rate: viewModel.rate)
            swapButton
            CurrencyOutputView(currency: $viewModel.toCurrency,
                                 amount: toAmount,
                                   rate: viewModel.rate)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }

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
    let viewModel = CurrencyConverterViewModel( currencyService: service)
    CurrencyConverterView(viewModel: viewModel)
}
