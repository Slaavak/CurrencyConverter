//
//  CurrencyOutputView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import SwiftUI

struct CurrencyOutputView: View {
    @Binding var fromCurrency: Currency
    @Binding var toCurrency: Currency
    @Binding var amount: String
    @Binding var rate: Double?

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            NavigationLink {
                CurrencyPickerView(selection: $toCurrency)
            } label: {
                HStack {
                    Text(toCurrency.code + " - " + toCurrency.title)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .buttonStyle(.plain)
            .padding(.bottom, 2)

            if let rate {
                Text("1 \(toCurrency.code) ≈ \(String(format: "%.2f", 1.0 / rate)) \(fromCurrency.code)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Text(amount)
                .font(.largeTitle.bold())
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 2)
        )
    }
}

#Preview {
    CurrencyOutputView(fromCurrency: .constant(.USD),
                         toCurrency: .constant(.AUD),
                             amount: .constant("100"),
                               rate: .constant(1.5))
}
