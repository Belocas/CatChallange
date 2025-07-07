//
//  CatDetailsViewModel.swift
//  Cats
//
//  Created by Isabel Couto on 07/07/2025.
//

import Foundation


@MainActor
class CatDetailsViewModel: ObservableObject {
    private let cat: Cat
    private let catService = CatService()
    
    init(cat: Cat) {
        self.cat = cat
        downloadImage()
    }
    var name: String {
        cat.name
    }
    
    var origin:String{
        cat.origin
    }
    
    var temperament:String{
        cat.temperament
    }
    
    var description:String{
        cat.description
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
