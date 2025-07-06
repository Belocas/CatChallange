//
//  CatListViewModel.swift
//  Cats
//
//  Created by Isabel Couto on 05/07/2025.
//

import Foundation


@MainActor
class CatListViewModel: ObservableObject {
    @Published var cats: [Cat] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let catService = CatService()
    private let dataManager = CatDataManager()
    private var currentPage = 0
    private let limit = 10

    func loadNextPage() {
            guard !isLoading else { return }
            isLoading = true

            catService.fetchCats(limit: limit, page: currentPage) { [weak self] result in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch result {
                    case .success(let newCats):
                        self?.cats.append(contentsOf: newCats)
                        self?.dataManager.save(cats: newCats) // grava localmente
                        self?.currentPage += 1
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    
    
    func getCats(){
        let context = PersistenceController.shared.container.viewContext
        let total = self.dataManager.countCats(in: context) ?? 0
        print("Total guardado: countCats(in: \(total))")

    }
}
