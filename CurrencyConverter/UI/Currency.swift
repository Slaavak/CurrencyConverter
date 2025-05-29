//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import Foundation

enum Currency: String, CaseIterable, Identifiable, Hashable {
    var id: String { self.rawValue }

    case EUR = "Euro"
    case USD = "US Dollar"
    case JPY = "Japanese Yen"
    case BGN = "Bulgarian Lev"
    case CZK = "Czech Republic Koruna"
    case DKK = "Danish Krone"
    case GBP = "British Pound Sterling"
    case HUF = "Hungarian Forint"
    case PLN = "Polish Zloty"
    case RON = "Romanian Leu"
    case SEK = "Swedish Krona"
    case CHF = "Swiss Franc"
    case ISK = "Icelandic Króna"
    case NOK = "Norwegian Krone"
    case HRK = "Croatian Kuna"
    case RUB = "Russian Ruble"
    case TRY = "Turkish Lira"
    case AUD = "Australian Dollar"
    case BRL = "Brazilian Real"
    case CAD = "Canadian Dollar"
    case CNY = "Chinese Yuan"
    case HKD = "Hong Kong Dollar"
    case IDR = "Indonesian Rupiah"
    case ILS = "Israeli New Sheqel"
    case INR = "Indian Rupee"
    case KRW = "South Korean Won"
    case MXN = "Mexican Peso"
    case MYR = "Malaysian Ringgit"
    case NZD = "New Zealand Dollar"
    case PHP = "Philippine Peso"
    case SGD = "Singapore Dollar"
    case THB = "Thai Baht"
    case ZAR = "South African Rand"
}
