//
//  CatGridItemViewModel.swift
//  Cats
//
//  Created by Isabel Couto on 06/07/2025.
//
import Foundation

class CatGridItemViewModel: ObservableObject {
    private let cat: Cat
    private let catService = CatService()
   var isFavorite = true
    
    init(cat: Cat) {
        self.cat = cat
        downloadImage()
    }

    var name: String {
        cat.name
    }
    
    @Published var imageURL:URL?

    func downloadImage(){
        catService.fetchCatImage(idCat: cat.imageId){ result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let url):
                            print("url " + url)
                            self.imageURL = URL(string:url)
                            
                        case .failure(let error):
                           print("erro")
                            self.imageURL = nil
                        }
                    }
                }
    }
}
