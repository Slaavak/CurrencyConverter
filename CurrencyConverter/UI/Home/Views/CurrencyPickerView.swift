//
//  CurrencyPickerView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import SwiftUI

struct CurrencyPickerView: View {
    @Binding var selection: Currency
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            ForEach(Currency.allCases) { currency in
                Button(action: {
                    selection = currency
                    dismiss()
                }) {
                    HStack {
                        Text(currency.flag)
                        Text(currency.code + " - " + currency.title)
                        Spacer()
                        if selection == currency {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .navigationTitle("Choose Currency")
    }
}
