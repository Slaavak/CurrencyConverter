//
//  HistoryViewModel.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import SwiftUI
import SwiftData
import Combine

protocol HistoryViewModelProtocol {
    var filteredItems: [Record] { get }

    func loadMore() async
}

@MainActor
class HistoryViewModel: ObservableObject {

    var dataSource: DataSourceProtocol

    @Published var searchText: String = ""
    @Published var items: [Record] = []
    @Published var hasMoreItems = true

    private let pageSize = 20
    private var currentOffset = 0
    private var cancellables = Set<AnyCancellable>()

    init(dataSource: DataSourceProtocol) {
        self.dataSource = dataSource

        self.loadInitial()
        self.setUpSubscriptions()
    }
}

//MARK: - Public
extension HistoryViewModel {
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

    func loadMore() async {
        guard hasMoreItems else { return }

        let fetched = await dataSource.fetchRecords(limit: pageSize, offset: currentOffset)
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
                Task {
                    self.items = await self.dataSource.fetchRecords(limit: 20, offset: 0)
                    self.currentOffset = 0
                    self.hasMoreItems = true
                }
            }
            .store(in: &cancellables)
    }

    func loadInitial() {
        Task {
            let fetched = await dataSource.fetchRecords(limit: pageSize, offset: 0)
            items = fetched
            currentOffset = fetched.count
            hasMoreItems = fetched.count == pageSize
        }
    }
}
