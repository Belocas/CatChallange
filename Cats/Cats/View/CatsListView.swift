//
//  CatsListView.swift
//  Cats
//
//  Created by Isabel Couto on 05/07/2025.
//

import SwiftUI

struct CatsListView: View {
    @StateObject private var viewModel = CatListViewModel()

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.filteredCats, id: \.id) { cat in
                        CatGridItem(cat: cat)
                            .onAppear {
                                if cat == viewModel.cats.last {
                                       viewModel.loadNextPage()
                                       viewModel.getCats()
                                   }
                            }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .gridCellColumns(2) // ocupa duas colunas
                    }
                }
                .padding()
            }
            .searchable(text: $viewModel.searchText ,  prompt: "Search breeds")
            .navigationTitle("Cat Breeds")
            .onAppear {
                if viewModel.cats.isEmpty {
                    viewModel.loadNextPage()
                    viewModel.getCats()
                }
            }
            /*.alert(item: $viewModel.errorMessage) { message in
                Alert(title: Text("Error"), message: Text(message), dismissButton: .default(Text("OK")))
            }*/
        }
    }
}

#Preview {
    CatsListView()
}
