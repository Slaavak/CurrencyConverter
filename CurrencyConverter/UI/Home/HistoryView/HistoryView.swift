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

    var body: some View {
        VStack(alignment: .leading) {
            headerView
            historyList(isExpanded ? viewModel.filteredItems : Array(viewModel.filteredItems.prefix(5)))
        }
    }

    private var headerView: some View {
        HStack {
            if !isExpanded {
                Text("History")
                    .font(.title2)
                    .bold()
                Spacer()
                Button {
                    withAnimation(.spring) {
                        isExpanded.toggle()
                    }
                } label: {
                    Text("All history")
                        .font(.subheadline)
                }
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func historyList(_ items: [Record]) -> some View {
        if items.isEmpty {
            VStack(spacing: 12) {
                Spacer()
                Image(systemName: "clock.arrow.circlepath")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                    .foregroundColor(.gray)
                Text("History is empty")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .transition(.opacity)
        } else {
            List {
                ForEach(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.fromValue, specifier: "%.2f") \(item.fromCurrency.rawValue)")
                                .font(.headline)
                            Text("\(item.toValue, specifier: "%.2f") \(item.toCurrency.rawValue)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Image(systemName: "arrow.right.arrow.left")
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 4)
                    .onAppear {
                        if isExpanded, item == items.last {
                            Task {
                                await viewModel.loadMore()
                            }
                        }
                    }
                }

                if viewModel.hasMoreItems, isExpanded {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .padding()
                }
            }
            .if(isExpanded) {
                $0.searchable(text: $viewModel.searchText, prompt: "Sum and currency search")
            }
        }
    }
}

#Preview() {
    @Previewable @State var isExpanded = false
    let ds = DataSource(container: previewContainer,
                          context: previewContainer.mainContext)
    let viewModel = HistoryViewModel.init(dataSource: ds)
    HistoryView(viewModel: viewModel, isExpanded: $isExpanded)
}
