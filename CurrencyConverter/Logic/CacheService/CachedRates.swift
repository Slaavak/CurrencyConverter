//
//  CachedRates.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import Foundation

struct CachedRates: Codable, Equatable {
    let base: Currency
    var rates: [Currency: Double]
    var cachedAt: Date
}
