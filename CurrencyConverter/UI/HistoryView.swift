//
//  HistoryView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        List(0...100, id: \.self) { id in
                Text("Number: \(id)")
        }
    }
}

#Preview {
    HistoryView()
}
