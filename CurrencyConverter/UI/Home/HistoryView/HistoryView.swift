//
//  HistoryView.swift
//  CurrencyConverter
//
//  Created by Slava Korolevich on 29/05/2025.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel

    @Binding var isExpanded: Bool
    @State private var searchText: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            if !isExpanded {
                HStack {
                    Text("История")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    } label: {
                        if isExpanded {
                            Image(systemName: "xmark")
                                .scaleEffect(1.5)
                                .padding(.trailing)
                        } else {
                            Text("Вся история")
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.horizontal)
            }

            let displayedItems = isExpanded ? viewModel.items : Array(viewModel.items.prefix(through: 5))
            let filteredItems = displayedItems.filter { item in
                if searchText.isEmpty { return true }

                if let _ = Double(searchText.replacingOccurrences(of: ",", with: ".")) {
                    let fromString = String(format: "%.2f", item.fromAmount)
                    let toString = String(format: "%.2f", item.toAmount)
                    return fromString.contains(searchText) || toString.contains(searchText)
                }

                let query = searchText.lowercased()
                return item.fromCurrency.lowercased().contains(query) || item.toCurrency.lowercased().contains(query)
            }
            if isExpanded {
                List(filteredItems) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.fromAmount, specifier: "%.2f") \(item.fromCurrency)")
                                .font(.headline)
                            Text("\(item.toAmount, specifier: "%.2f") \(item.toCurrency)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Image(systemName: "arrow.right.arrow.left")
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 4)
                }
                .searchable(text: $searchText, prompt: "Поиск по валютам или суммам")
            } else {
                List(filteredItems) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.fromAmount, specifier: "%.2f") \(item.fromCurrency)")
                                .font(.headline)
                            Text("\(item.toAmount, specifier: "%.2f") \(item.toCurrency)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Image(systemName: "arrow.right.arrow.left")
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}

#Preview() {
    @Previewable @State var isExpanded = false
    HistoryView(viewModel: HistoryViewModel.init(), isExpanded: $isExpanded)
}
