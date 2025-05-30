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
        self.data = try container.decode([Currency: Double].self, forKey: .data)
    }
}
