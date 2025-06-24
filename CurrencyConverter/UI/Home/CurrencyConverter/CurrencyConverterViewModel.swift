//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import Combine
import Foundation
import SwiftUI

@MainActor
class CurrencyConverterViewModel: ObservableObject {

    var currencyService: CurrencyServiceProtocol
    var dataSource: DataSourceProtocol

    @Published var fromCurrency: Currency = .USD
    @Published var toCurrency: Currency = .EUR
    @Published var fromAmount: String = "1"
    @Published var toAmount: String = "0.00"
    @Published var rate: Double?
    @Published var currentRates: [Currency: Double] = [:]

    private var cancellables = Set<AnyCancellable>()

    init(currencyService: CurrencyServiceProtocol,
              dataSource: DataSourceProtocol) {
        self.currencyService = currencyService
        self.dataSource = dataSource

        self.loadStoredCurrencies()
        self.setUpSubscriptions()
    }
}

//MARK: - Public
extension CurrencyConverterViewModel {
    func saveConversion() {
        guard let fromAmount = Double(self.fromAmount),
              let toAmount = Double(self.toAmount) else { return }

        let entity = Record(timestamp: Date(),
                         fromCurrency: fromCurrency,
                            fromValue: fromAmount,
                           toCurrency: toCurrency,
                              toValue: toAmount)

        Task.detached {
            await self.dataSource.insert(entity)
        }
    }
}

//MARK: - Private
private extension CurrencyConverterViewModel {

    enum DefaultsKeys {
        static let fromCurrency = "lastFromCurrency"
        static let toCurrency = "lastToCurrency"
    }

    func setUpSubscriptions() {
        $fromCurrency
            .sink { [weak self] currency in
                guard let self else { return }
                UserDefaults.standard.set(currency.rawValue, forKey: DefaultsKeys.fromCurrency)
                self.fetchRates(currency)
            }
            .store(in: &cancellables)

        $toCurrency
            .sink { [weak self] currency in
                guard let self else { return }
                UserDefaults.standard.set(currency.rawValue, forKey: DefaultsKeys.toCurrency)
                rate = currentRates[currency]
                updateToAmount()
            }
            .store(in: &cancellables)

        $fromAmount
            .sink { [weak self] _ in
                guard let self else { return }
                self.updateToAmount()
            }
            .store(in: &cancellables)

        $fromAmount
            .dropFirst(1)
            .removeDuplicates()
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.saveConversion()
            }
            .store(in: &cancellables)
    }

    func loadStoredCurrencies() {
        if let fromRaw = UserDefaults.standard.string(forKey: DefaultsKeys.fromCurrency),
           let from = Currency(rawValue: fromRaw) {
            self.fromCurrency = from
        }

        if let toRaw = UserDefaults.standard.string(forKey: DefaultsKeys.toCurrency),
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
