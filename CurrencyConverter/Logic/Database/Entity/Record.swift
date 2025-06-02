//
//  Record.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import Foundation
import SwiftData

@Model
final class Record: Identifiable {
    var timestamp: Date

    var fromCurrency: Currency
    var fromValue: Double

    var toCurrency: Currency
    var toValue: Double

    init(
        timestamp: Date,
        fromCurrency: Currency,
        fromValue: Double,
        toCurrency: Currency,
        toValue: Double
    ) {
        self.timestamp = timestamp
        self.fromCurrency = fromCurrency
        self.fromValue = fromValue
        self.toCurrency = toCurrency
        self.toValue = toValue
    }
}
