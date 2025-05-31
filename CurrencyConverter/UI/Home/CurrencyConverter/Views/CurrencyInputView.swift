//
//  CurrencyInputView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import SwiftUI

struct CurrencyInputView: View {
    @Binding var fromCurrency: Currency
    @Binding var toCurrency: Currency
    @Binding var amount: String
    @Binding var rate: Double?
    @FocusState var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            NavigationLink {
                CurrencyPickerView(selection: $fromCurrency)
            } label: {
                HStack {
                    Text(fromCurrency.code + " - " + fromCurrency.title)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .buttonStyle(.plain)
            .padding(.bottom, 2)

            if let rate {
                Text("1 \(fromCurrency.code) ≈ \(String(format: "%.2f", rate)) \(toCurrency.code)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            TextField("Amount", text: $amount)
                .keyboardType(.decimalPad)
                .font(.largeTitle.bold())
                .focused($isFocused)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()

                        Button("Done") {
                            isFocused = false
                        }
                     }
                }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        .shadow(radius: 2)
    }
}

#Preview {
    CurrencyInputView(fromCurrency: .constant(.USD),
                        toCurrency: .constant(.AUD),
                            amount: .constant("100"),
                              rate: .constant(1.34))
}
