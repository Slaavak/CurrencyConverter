//
//  DataSource.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import Foundation
import SwiftData
import Combine

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

extension DataSource {
    func insert(_ entity: Record) {
        self.container?.mainContext.insert(entity)
        try? self.container?.mainContext.save()
        didInsertRecord.send()
    }

    func fetchRecords(limit: Int = 20, offset: Int = 0) -> [Record] {
        var fetchDescriptor = FetchDescriptor<Record>()
        fetchDescriptor.sortBy = [SortDescriptor(\.timestamp, order: .reverse)]
        fetchDescriptor.fetchLimit = limit
        fetchDescriptor.fetchOffset = offset

        return (try? self.container?.mainContext.fetch(fetchDescriptor)) ?? []
    }
}
