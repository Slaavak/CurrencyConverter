//
//  CurrencyOutputView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import SwiftUI

struct CurrencyOutputView: View {
    @ObservedObject var viewModel: CurrencyConverterViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            NavigationLink {
                CurrencyPickerView(selection: $viewModel.toCurrency)
            } label: {
                HStack {
                    Text(viewModel.toCurrency.code + " - " + viewModel.toCurrency.title)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .buttonStyle(.plain)
            .padding(.bottom, 2)

            if let rate = viewModel.rate, rate != 0 {
                Text("1 \(viewModel.toCurrency.code) ≈ \(String(format: "%.2f", 1.0 / rate)) \(viewModel.fromCurrency.code)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Text(viewModel.toAmount)
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
