//
//  CurrencyCacheService.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 31/05/2025.
//

import Foundation

protocol CurrencyCacheServiceProtocol {
    func loadCachedRates(for base: Currency) async -> CachedRates?
    func save(_ rates: CachedRates) async
    func clearCache() async
}

actor CurrencyCacheService: CurrencyCacheServiceProtocol {
    private let fileManager = FileManager.default
    private var cacheURL: URL {
        fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("currency_cache.json")
    }

    func loadCachedRates(for base: Currency) async -> CachedRates? {
        do {
            let data = try Data(contentsOf: self.cacheURL)
            if let cachedList = try? JSONDecoder().decode([CachedRates].self, from: data),
               let cached = cachedList.first(where: { $0.base == base }),
               self.isCacheValid(cached) {
                return cached
            }
        } catch {
            print("Failed to read cache: \(error)")
        }
        return nil
    }

    func save(_ rates: CachedRates) async {
        var existingList: [CachedRates] = []

        if let data = try? Data(contentsOf: self.cacheURL),
           let decoded = try? JSONDecoder().decode([CachedRates].self, from: data) {
            existingList = decoded
        }

        if let index = existingList.firstIndex(where: { $0.base == rates.base }) {
            existingList[index] = rates
        } else {
            existingList.append(rates)
        }

        guard let encoded = try? JSONEncoder().encode(existingList) else { return }
        do {
            try encoded.write(to: self.cacheURL)
        } catch {
            print("Failed to write cache: \(error)")
        }
    }

    func clearCache() async {
        try? fileManager.removeItem(at: cacheURL)
    }
}

// MARK: - Private
private extension CurrencyCacheService {

    func isCacheValid(_ cached: CachedRates) -> Bool {
        return Date().timeIntervalSince(cached.cachedAt) < 86400
    }
}
