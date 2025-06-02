//
//  HistoryViewModel.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import SwiftUI
import SwiftData
import Combine

@MainActor
class HistoryViewModel: ObservableObject {

    var dataSource: DataSource

    @Published var searchText: String = ""
    @Published var items: [Record] = []
    @Published var hasMoreItems = true

    private let pageSize = 20
    private var currentOffset = 0
    private var cancellables = Set<AnyCancellable>()

    init(dataSource: DataSource) {
        self.dataSource = dataSource

        self.loadInitial()
        self.setUpSubscriptions()
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

//MARK: - Public
extension HistoryViewModel {
    func loadMore() {
        guard hasMoreItems else { return }

        let fetched = dataSource.fetchRecords(limit: pageSize, offset: currentOffset)
        items.append(contentsOf: fetched)
        currentOffset += fetched.count
        hasMoreItems = fetched.count == pageSize
    }
}

//MARK: - Private
private extension HistoryViewModel {
    func setUpSubscriptions() {
        dataSource.didInsertRecord
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                guard let self else { return }
                self.items = dataSource.fetchRecords()
            }
            .store(in: &cancellables)
    }

    func loadInitial() {
        let fetched = dataSource.fetchRecords(limit: pageSize)
        items = fetched
        currentOffset = fetched.count
        hasMoreItems = fetched.count == pageSize
    }
}
