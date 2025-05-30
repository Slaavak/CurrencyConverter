//
//  CurrencyCacheService.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import Foundation

struct CachedRates: Codable, Equatable {
    let base: Currency
    var rates: [Currency: Double]
    var cachedAt: Date
}
protocol CurrencyCacheServiceProtocol {
    func loadCachedRates(for base: Currency) -> CachedRates?
    func save(_ rates: CachedRates)
    func clearCache()
    func isCacheValid(for base: Currency) -> Bool
}

class CurrencyCacheService: CurrencyCacheServiceProtocol {
    private let fileManager = FileManager.default
    private var cacheURL: URL {
        fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("currency_cache.json")
    }

    func loadCachedRates(for base: Currency) -> CachedRates? {
        guard let data = try? Data(contentsOf: cacheURL),
              let cachedList = try? JSONDecoder().decode([CachedRates].self, from: data),
              let cached = cachedList.first(where: { $0.base == base }) else {
            return nil
        }
        return cached
    }

    func save(_ rates: CachedRates) {
        var existingList: [CachedRates] = []

        if let data = try? Data(contentsOf: cacheURL),
           let decoded = try? JSONDecoder().decode([CachedRates].self, from: data) {
            existingList = decoded
        }

        if let index = existingList.firstIndex(where: { $0.base == rates.base }) {
            existingList[index] = rates
        } else {
            existingList.append(rates)
        }

        guard let encoded = try? JSONEncoder().encode(existingList) else { return }
        try? encoded.write(to: cacheURL)
    }

    func clearCache() {
        try? fileManager.removeItem(at: cacheURL)
    }

    func isCacheValid(for base: Currency) -> Bool {
        guard let cached = loadCachedRates(for: base) else { return false }
        return Date().timeIntervalSince(cached.cachedAt) < 86400
    }
}
