//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import Combine
import Foundation

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

        self.loadDefaultRates()
        self.setUpSubscriptions()
    }
}

//MARK: - Private
private extension CurrencyConverterViewModel {

    func setUpSubscriptions() {
        $fromCurrency.sink { [weak self] currency in
            guard let self else { return }
            UserDefaults.standard.set(currency.rawValue, forKey: "lastFromCurrency")
            self.fetchRates(currency)
        }
        .store(in: &cancellables)

        $toCurrency.sink { [weak self] currency in
            guard let self else { return }
            UserDefaults.standard.set(currency.rawValue, forKey: "lastToCurrency")
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

    func loadDefaultRates() {
        if let fromRaw = UserDefaults.standard.string(forKey: "lastFromCurrency"),
           let from = Currency(rawValue: fromRaw) {
            self.fromCurrency = from
        }

        if let toRaw = UserDefaults.standard.string(forKey: "lastToCurrency"),
           let to = Currency(rawValue: toRaw) {
            self.toCurrency = to
        }
    }

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
