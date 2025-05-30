//
//  CurrencyOutputView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import SwiftUI

struct CurrencyOutputView: View {
    @Binding var currency: Currency
    var amount: String

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

            Text("1 \(currency.code) ≈ ...")
                .font(.caption)
                .foregroundColor(.gray)

            Text(amount)
                .font(.largeTitle.bold())
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        .shadow(radius: 2)
    }
}

#Preview {
    CurrencyOutputView(currency: .constant(.AUD),
                         amount: "100")
}
