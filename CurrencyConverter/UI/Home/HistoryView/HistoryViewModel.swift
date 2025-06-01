//
//  HistoryViewModel.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import SwiftUI
import SwiftData

@MainActor
class HistoryViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var items: [Record] = []

    var dataSource: DataSource

    init(dataSource: DataSource) {
        self.dataSource = dataSource

        Task {
            items = dataSource.fetchRecords()
        }
    }

    var filteredItems: [Record] {
        guard !searchText.isEmpty else { return items }

        let normalizedSearchText = searchText.replacingOccurrences(of: ",", with: ".")
        if let _ = Double(normalizedSearchText) {
            return items.filter {
                String(format: "%.2f", $0.fromValue).contains(normalizedSearchText) ||
                String(format: "%.2f", $0.toValue).contains(normalizedSearchText)
            }
        }

        let query = searchText.lowercased()
        return items.filter {
            $0.fromCurrency.rawValue.lowercased().contains(query) ||
            $0.toCurrency.rawValue.lowercased().contains(query)
        }
    }

}
