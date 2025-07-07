//
//  CatGridItem.swift
//  Cats
//
//  Created by Isabel Couto on 05/07/2025.
//

import SwiftUI

struct CatGridItem: View {
    @StateObject private var viewModel: CatGridItemViewModel
    
    init(cat: Cat) {
        _viewModel = StateObject(wrappedValue: CatGridItemViewModel(cat: cat))
    }


    var body: some View {
            
        
           VStack(spacing: 8) {
               
               ZStack {
                   Rectangle()
                       .fill(Color.white) // fundo para manter altura mesmo sem imagem
                       .frame(height: 120)
                       .cornerRadius(10)
                   
                   
                   // Imagem estática
                   if let url = viewModel.imageURL {
                       AsyncImage(url: url) { phase in
                           switch phase {
                           case .empty:
                               ProgressView()
                                   .frame(height: 120)
                           case .success(let image):
                               image
                                   .resizable()
                                   .aspectRatio(contentMode: .fit) // mantém proporção
                                   .frame(height: 120)
                                   .clipped()
                                   .cornerRadius(10)
                           case .failure:
                               Image(systemName: "photo")
                                   .resizable()
                                   .scaledToFit()
                                   .frame(height: 120)
                                   .foregroundColor(.gray)
                           @unknown default:
                               EmptyView()
                           }
                       }
                   } else {
                       Image(systemName: "photo")
                           .resizable()
                           .scaledToFit()
                           .frame(height: 120)
                           .foregroundColor(.gray)
                   }
                   
                   
               }
               Text(viewModel.name)
                   .font(.headline)
                   .lineLimit(1)
                   .minimumScaleFactor(0.7)
           }
           .padding()
           .background(Color.white)
           .cornerRadius(12)
           .shadow(radius: 3)
       }
}
