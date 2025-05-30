//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import Foundation

final class CurrencyConverterViewModel: ObservableObject {

    var currencyService: CurrencyServiceProtocol
    var currentRates: [Currency: Double] = [:]

    init(currencyService: CurrencyServiceProtocol) {
        self.currencyService = currencyService

        Task {
            let response = try await currencyService.fetchRates(base: .USD, to: Currency.allCases)
            currentRates = response.data
        }
    }
}

extension CurrencyConverterViewModel {
    
}
