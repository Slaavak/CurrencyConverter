//
//  Item.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import Foundation
import SwiftData

@Model
final class Record {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
