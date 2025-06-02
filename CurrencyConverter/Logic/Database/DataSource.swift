//
//  DataSource.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import Foundation
import SwiftData
import Combine

protocol DataSourceProtocol: AnyObject {
    func insert(_ entity: Record) async
    func fetchRecords(limit: Int, offset: Int) async -> [Record]
}

@MainActor
class DataSource {

    let didInsertRecord = PassthroughSubject<Void, Never>()

    private let container: ModelContainer?
    private let context: ModelContext?

    init(container: ModelContainer?, context: ModelContext?) {
        self.container = container
        self.context = context
    }
}

// MARK: Public
extension DataSource: DataSourceProtocol {
    func insert(_ entity: Record) async {
        self.container?.mainContext.insert(entity)
        try? self.container?.mainContext.save()
        didInsertRecord.send()
    }

    func fetchRecords(limit: Int = 20, offset: Int = 0) async -> [Record] {
        var fetchDescriptor = FetchDescriptor<Record>()
        fetchDescriptor.sortBy = [SortDescriptor(\.timestamp, order: .reverse)]
        fetchDescriptor.fetchLimit = limit
        fetchDescriptor.fetchOffset = offset

        return (try? self.container?.mainContext.fetch(fetchDescriptor)) ?? []
    }
}
