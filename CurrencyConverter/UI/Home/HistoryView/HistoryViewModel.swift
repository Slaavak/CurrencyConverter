//
//  HistoryViewModel.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import Foundation

@MainActor
class HistoryViewModel: ObservableObject {
    struct ConversionItem: Identifiable {
        let id = UUID()
        let fromCurrency: String
        let toCurrency: String
        let fromAmount: Double
        let toAmount: Double
    }

    @Published var items: [ConversionItem] = [
        .init(fromCurrency: "USD", toCurrency: "EUR", fromAmount: 1, toAmount: 91),
        .init(fromCurrency: "EUR", toCurrency: "RUB", fromAmount: 2, toAmount: 4900.231),
        .init(fromCurrency: "GBP", toCurrency: "USD", fromAmount: 3, toAmount: 250.231),
        .init(fromCurrency: "USD", toCurrency: "EUR", fromAmount: 4, toAmount: 91.57),
        .init(fromCurrency: "EUR", toCurrency: "RUB", fromAmount: 5, toAmount: 4900.88),
        .init(fromCurrency: "GBP", toCurrency: "USD", fromAmount: 6, toAmount: 250.21),
        .init(fromCurrency: "USD", toCurrency: "EUR", fromAmount: 7, toAmount: 91.231),
        .init(fromCurrency: "EUR", toCurrency: "RUB", fromAmount: 8, toAmount: 4900.031),
        .init(fromCurrency: "GBP", toCurrency: "USD", fromAmount: 9, toAmount: 250.11),
        .init(fromCurrency: "USD", toCurrency: "EUR", fromAmount: 10, toAmount: 91.002),
        .init(fromCurrency: "EUR", toCurrency: "RUB", fromAmount: 11, toAmount: 4900.02),
        .init(fromCurrency: "GBP", toCurrency: "USD", fromAmount: 12, toAmount: 250),
        .init(fromCurrency: "USD", toCurrency: "EUR", fromAmount: 13, toAmount: 91),
        .init(fromCurrency: "EUR", toCurrency: "RUB", fromAmount: 14, toAmount: 4900),
        .init(fromCurrency: "GBP", toCurrency: "USD", fromAmount: 15, toAmount: 250),
        .init(fromCurrency: "USD", toCurrency: "EUR", fromAmount: 16, toAmount: 91),
        .init(fromCurrency: "EUR", toCurrency: "RUB", fromAmount: 17, toAmount: 4900),
        .init(fromCurrency: "GBP", toCurrency: "USD", fromAmount: 18, toAmount: 250),
        .init(fromCurrency: "USD", toCurrency: "EUR", fromAmount: 19, toAmount: 91),
        .init(fromCurrency: "EUR", toCurrency: "RUB", fromAmount: 20, toAmount: 4900),
        .init(fromCurrency: "GBP", toCurrency: "USD", fromAmount: 21, toAmount: 250)
    ]
}
