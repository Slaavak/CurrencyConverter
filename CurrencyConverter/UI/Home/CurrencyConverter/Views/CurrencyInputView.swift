//
//  CurrencyInputView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 30/05/2025.
//

import SwiftUI

struct CurrencyInputView: View {
    @ObservedObject var viewModel: CurrencyConverterViewModel

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            NavigationLink {
                CurrencyPickerView(selection: $viewModel.fromCurrency)
            } label: {
                HStack {
                    Text(viewModel.fromCurrency.code + " - " + viewModel.fromCurrency.title)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .buttonStyle(.plain)
            .padding(.bottom, 2)

            if let rate = viewModel.rate {
                Text("1 \(viewModel.fromCurrency.code) ≈ \(String(format: "%.2f", rate)) \(viewModel.toCurrency.code)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            TextField(LocalizedStringKey("Amount"), text: $viewModel.fromAmount)
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
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 2)
        )
    }
}
