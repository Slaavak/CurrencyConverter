//
//  ConvertationView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import SwiftUI

struct CurrencyConverterView: View {
    @State private var fromCurrency: Currency = .USD
    @State private var toCurrency: Currency = .EUR
    @State private var fromAmount: String = "1"

    var viewModel: CurrencyConverterViewModel

    init(viewModel: CurrencyConverterViewModel) {
        self.viewModel = viewModel
    }

    var rate: Double? {
        viewModel.currentRates[toCurrency]
    }

    var toAmount: String {
        let value = Double(fromAmount) ?? 0
        let result = value * (rate ?? 0.0)
        return String(format: "%.2f", result)
    }

    var body: some View {
        VStack(spacing:16) {
            CurrencyInputView(currency: $fromCurrency,
                                amount: $fromAmount,
                                  rate: rate)
            swapButton
            CurrencyOutputView(currency: $toCurrency,
                                 amount: toAmount,
                                   rate: rate)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }

    var swapButton: some View {
        Button(action: {
            swap(&fromCurrency, &toCurrency)
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
