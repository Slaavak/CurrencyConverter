//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import Foundation

enum Currency: String, CaseIterable, Identifiable, Hashable {
    case EUR, USD, JPY, BGN, CZK, DKK, GBP, HUF, PLN, RON, SEK, CHF, ISK, NOK, HRK, RUB, TRY, AUD, BRL, CAD, CNY, HKD, IDR, ILS, INR, KRW, MXN, MYR, NZD, PHP, SGD, THB, ZAR

    var id: String { self.rawValue }
    var code: String { self.rawValue }

    var flag: String {
        switch self {
        case .USD: return "🇺🇸"
        case .EUR: return "🇪🇺"
        case .JPY: return "🇯🇵"
        case .BGN: return "🇧🇬"
        case .CZK: return "🇨🇿"
        case .DKK: return "🇩🇰"
        case .GBP: return "🇬🇧"
        case .HUF: return "🇭🇺"
        case .PLN: return "🇵🇱"
        case .RON: return "🇷🇴"
        case .SEK: return "🇸🇪"
        case .CHF: return "🇨🇭"
        case .ISK: return "🇮🇸"
        case .NOK: return "🇳🇴"
        case .HRK: return "🇭🇷"
        case .RUB: return "🇷🇺"
        case .TRY: return "🇹🇷"
        case .AUD: return "🇦🇺"
        case .BRL: return "🇧🇷"
        case .CAD: return "🇨🇦"
        case .CNY: return "🇨🇳"
        case .HKD: return "🇭🇰"
        case .IDR: return "🇮🇩"
        case .ILS: return "🇮🇱"
        case .INR: return "🇮🇳"
        case .KRW: return "🇰🇷"
        case .MXN: return "🇲🇽"
        case .MYR: return "🇲🇾"
        case .NZD: return "🇳🇿"
        case .PHP: return "🇵🇭"
        case .SGD: return "🇸🇬"
        case .THB: return "🇹🇭"
        case .ZAR: return "🇿🇦"
        }
    }

    var title: String {
        switch self {
        case .EUR: return String(localized: "Euro")
        case .USD: return String(localized: "US Dollar")
        case .JPY: return String(localized: "Japanese Yen")
        case .BGN: return String(localized: "Bulgarian Lev")
        case .CZK: return String(localized: "Czech Republic Koruna")
        case .DKK: return String(localized: "Danish Krone")
        case .GBP: return String(localized: "British Pound Sterling")
        case .HUF: return String(localized: "Hungarian Forint")
        case .PLN: return String(localized: "Polish Zloty")
        case .RON: return String(localized: "Romanian Leu")
        case .SEK: return String(localized: "Swedish Krona")
        case .CHF: return String(localized: "Swiss Franc")
        case .ISK: return String(localized: "Icelandic Króna")
        case .NOK: return String(localized: "Norwegian Krone")
        case .HRK: return String(localized: "Croatian Kuna")
        case .RUB: return String(localized: "Russian Ruble")
        case .TRY: return String(localized: "Turkish Lira")
        case .AUD: return String(localized: "Australian Dollar")
        case .BRL: return String(localized: "Brazilian Real")
        case .CAD: return String(localized: "Canadian Dollar")
        case .CNY: return String(localized: "Chinese Yuan")
        case .HKD: return String(localized: "Hong Kong Dollar")
        case .IDR: return String(localized: "Indonesian Rupiah")
        case .ILS: return String(localized: "Israeli New Sheqel")
        case .INR: return String(localized: "Indian Rupee")
        case .KRW: return String(localized: "South Korean Won")
        case .MXN: return String(localized: "Mexican Peso")
        case .MYR: return String(localized: "Malaysian Ringgit")
        case .NZD: return String(localized: "New Zealand Dollar")
        case .PHP: return String(localized: "Philippine Peso")
        case .SGD: return String(localized: "Singapore Dollar")
        case .THB: return String(localized: "Thai Baht")
        case .ZAR: return String(localized: "South African Rand")
        }
    }
}

extension Currency: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let value = Currency(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid currency code: \(rawValue)")
        }
        self = value
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }
}
