//
//  DataSource.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import Foundation
import SwiftData

@MainActor
class DataSource {
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
    }

    func fetchRecords() -> [Record] {
        let fetchDescriptor = FetchDescriptor<Record>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
        let contacts = try? self.container?.mainContext.fetch(fetchDescriptor)
        return contacts ?? []
    }
}
