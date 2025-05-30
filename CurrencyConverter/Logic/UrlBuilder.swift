//
//  UrlBuilder.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import Foundation

protocol UrlBuilderProtocol {
    func buildUrl(for endpoint: UrlBuilder.Endpoints) -> URL?
}

class UrlBuilder {
    let baseURL = "https://api.freecurrencyapi.com/v1"

    enum Endpoints {
        case latest(base: Currency, to: [Currency])

        var url: String {
            switch self {
            case .latest(let baseCurrency, let toCurrencies):
                let currencies = toCurrencies.map(\.code).joined(separator: ",")
                return "/latest?apikey=YOUR_API_KEY&base_currency=\(baseCurrency.code)&currencies=\(currencies)"
            }
        }
    }
}

extension UrlBuilder: UrlBuilderProtocol {
    func buildUrl(for endpoint: Endpoints) -> URL? {
        URL(string: baseURL + endpoint.url)
    }
}

