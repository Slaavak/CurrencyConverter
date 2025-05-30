//
//  Environment.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import Foundation

public enum EnvironmentKeys {
    enum Keys {
        static let currencyApiKey = "CURRENCY_API_KEY"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }

        return dict
    }()

    static let currencyApiKey: String? = {
        guard let key = infoDictionary[Keys.currencyApiKey] as? String else {
            fatalError("CurrencyApiKey not set in plist")
        }

        return key
    }()
}
