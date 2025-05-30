//
//  LatestRateResponse.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import Foundation

struct LatestRateResponse: Decodable {
    let data: [Currency: Double]
}

extension LatestRateResponse {
    private enum CodingKeys: String, CodingKey {
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawData = try container.decode([String: Double].self, forKey: .data)

        var parsed: [Currency: Double] = [:]

        for (key, value) in rawData {
            if let currency = Currency(rawValue: key) {
                parsed[currency] = value
            } else {
                print("Unable to parse currency \(key)")
            }
        }

        self.data = parsed
    }
}
