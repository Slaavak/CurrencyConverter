//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import Foundation

protocol CurrencyServiceProtocol {
    func fetchRates(base: Currency, to currencies: [Currency]) async throws -> LatestRateResponse
}

enum CurrencyServiceError: Error {
    case invalidURL
    case invalidStatusCode
    case invalidResponse
    case decodingFailed
}

class CurrencyService {
    private let urlBuilder: UrlBuilderProtocol
    private let session: URLSessionProtocol
    private let cacheService: CurrencyCacheServiceProtocol

    init(
        urlBuilder: UrlBuilderProtocol = UrlBuilder(),
        session: URLSessionProtocol = URLSession.shared,
        cacheService: CurrencyCacheServiceProtocol = CurrencyCacheService()
    ) {
        self.urlBuilder = urlBuilder
        self.session = session
        self.cacheService = cacheService
    }
}

extension CurrencyService: CurrencyServiceProtocol {

    func fetchRates(base: Currency, to currencies: [Currency]) async throws -> LatestRateResponse {
        if let cached = cacheService.loadCachedRates(for: base) {
            print("Take cache for base: \(base)")
            return LatestRateResponse(data: cached.rates)
        }

        guard let url = urlBuilder.buildUrl(for: .latest(base: base, to: currencies)) else {
            throw CurrencyServiceError.invalidURL
        }

        let response: LatestRateResponse = try await fetch(url: url)
        let cached = CachedRates(base: base, rates: response.data, cachedAt: Date())
        cacheService.save(cached)
        return response
    }
}

extension CurrencyService {
    func fetch<T: Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10

        self.log(request)
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw CurrencyServiceError.invalidResponse
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw CurrencyServiceError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw CurrencyServiceError.invalidStatusCode
        }

        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw CurrencyServiceError.decodingFailed
        }
    }

    func log(_ request: URLRequest) {
        let log = "request url: \(request.url!.absoluteString)"
        print(log)
    }
}
