//
//  ConvertationView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import SwiftUI

struct CurrencyConverterView: View {
    @State private var fromCurrency: Currency = .USD
    @State private var toCurrency: Currency = .IDR
    @State private var fromAmount: String = "1"

    var currencyService: CurrencyServiceProtocol

    init(currencyService: CurrencyServiceProtocol) {
        self.currencyService = currencyService
    }

    var toAmount: String {
        let value = Double(fromAmount.replacingOccurrences(of: ",", with: "")) ?? 0
        let result = value * 3.78
        return String(format: "%.2f", result)
    }

    var body: some View {
        VStack(spacing:16) {
            CurrencyInputView(currency: $fromCurrency, amount: $fromAmount)
            swapButton
            CurrencyOutputView(currency: $toCurrency, amount: toAmount)
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
    CurrencyConverterView()
}
