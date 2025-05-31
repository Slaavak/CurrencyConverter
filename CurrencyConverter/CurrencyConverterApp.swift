//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import SwiftUI
import SwiftData

@main
struct CurrencyConverterApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Record.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
