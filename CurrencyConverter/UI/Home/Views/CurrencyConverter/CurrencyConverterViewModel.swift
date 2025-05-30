//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import Combine

@MainActor
final class CurrencyConverterViewModel: ObservableObject {

    var currencyService: CurrencyServiceProtocol

    @Published var fromCurrency: Currency = .USD
    @Published var toCurrency: Currency = .EUR
    @Published var fromAmount: String = "1"
    @Published var toAmount: String = "0.00"
    @Published var rate: Double?
    @Published var currentRates: [Currency: Double] = [:]

    private var cancellables = Set<AnyCancellable>()

    init(currencyService: CurrencyServiceProtocol) {
        self.currencyService = currencyService

        $fromCurrency.sink { [weak self] currency in
            guard let self else { return }
            self.fetchRates(currency)
        }
        .store(in: &cancellables)

        $toCurrency.sink { [weak self] currency in
            guard let self else { return }
            rate = currentRates[currency]
            updateToAmount()
        }
        .store(in: &cancellables)

        $fromAmount.sink { [weak self] _ in
            guard let self else { return }
            updateToAmount()
        }
        .store(in: &cancellables)
    }
}

//MARK: - Private
private extension CurrencyConverterViewModel {

    func fetchRates(_ currency: Currency) {
        Task {
            let response = try await currencyService.fetchRates(base: currency, to: Currency.allCases)
            self.currentRates = response.data
            self.rate = currentRates[toCurrency]
            self.updateToAmount()
        }
    }

    func updateToAmount() {
        let value = Double(fromAmount) ?? 0
        let result = value * (rate ?? 0.0)
        toAmount = String(format: "%.2f", result)
    }
}
