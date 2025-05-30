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
        case .EUR: return "Euro"
        case .USD: return "US Dollar"
        case .JPY: return "Japanese Yen"
        case .BGN: return "Bulgarian Lev"
        case .CZK: return "Czech Republic Koruna"
        case .DKK: return "Danish Krone"
        case .GBP: return "British Pound Sterling"
        case .HUF: return "Hungarian Forint"
        case .PLN: return "Polish Zloty"
        case .RON: return "Romanian Leu"
        case .SEK: return "Swedish Krona"
        case .CHF: return "Swiss Franc"
        case .ISK: return "Icelandic Króna"
        case .NOK: return "Norwegian Krone"
        case .HRK: return "Croatian Kuna"
        case .RUB: return "Russian Ruble"
        case .TRY: return "Turkish Lira"
        case .AUD: return "Australian Dollar"
        case .BRL: return "Brazilian Real"
        case .CAD: return "Canadian Dollar"
        case .CNY: return "Chinese Yuan"
        case .HKD: return "Hong Kong Dollar"
        case .IDR: return "Indonesian Rupiah"
        case .ILS: return "Israeli New Sheqel"
        case .INR: return "Indian Rupee"
        case .KRW: return "South Korean Won"
        case .MXN: return "Mexican Peso"
        case .MYR: return "Malaysian Ringgit"
        case .NZD: return "New Zealand Dollar"
        case .PHP: return "Philippine Peso"
        case .SGD: return "Singapore Dollar"
        case .THB: return "Thai Baht"
        case .ZAR: return "South African Rand"
        }
    }
}
