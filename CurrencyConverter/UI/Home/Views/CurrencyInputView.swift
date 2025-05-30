//
//  CurrencyInputView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import SwiftUI

struct CurrencyInputView: View {
    @Binding var currency: Currency
    @Binding var amount: String
    var rate: Double?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            NavigationLink {
                CurrencyPickerView(selection: $currency)
            } label: {
                HStack {
                    Text(currency.code + " - " + currency.title)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .buttonStyle(.plain)
            .padding(.bottom, 2)

            if let rate {
                Text("1 \(currency.code) ≈ \(String(format: "%.2f", rate))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            TextField("Amount", text: $amount)
                .keyboardType(.decimalPad)
                .font(.largeTitle.bold())
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        .shadow(radius: 2)
    }
}

#Preview {
    CurrencyInputView(currency: .constant(.AUD),
                        amount: .constant("100"))
}
