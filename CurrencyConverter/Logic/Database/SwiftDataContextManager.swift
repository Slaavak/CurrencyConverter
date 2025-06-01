//
//  SwiftDataContextManager.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import Foundation
import SwiftData

class SwiftDataContextManager {
    static let shared = SwiftDataContextManager()

    var container: ModelContainer?
    var context : ModelContext?

    private init() {
        do {
            container = try setupModelContainer()
            if let container {
                context = ModelContext(container)
                context?.autosaveEnabled = true
            }
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }

    func setupModelContainer() throws -> ModelContainer {
        do {
            let schema = Schema([Record.self])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            // container
            let container = try ModelContainer(
                for: schema,
                configurations: [config]
            )

            return container
        } catch {
            debugPrint("Error initializing database container:", error)
            throw error
        }
    }

}

