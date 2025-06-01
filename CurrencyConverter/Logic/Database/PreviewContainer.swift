//
//  PreviewContainer.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Record.self,
                                configurations: ModelConfiguration(isStoredInMemoryOnly: true))

        for _ in 0...20 {
            let fromCurrency = Currency.allCases.randomElement()!
            let toCurrency = Currency.allCases.randomElement()!

            let item = Record(timestamp: Date(),
                           fromCurrency: fromCurrency,
                              fromValue: Double.random(in: 10...100),
                             toCurrency: toCurrency,
                                toValue: Double.random(in: 10...100))

            container.mainContext.insert(item)
        }

        try container.mainContext.save()

        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
