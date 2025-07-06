//
//  CatGridItem.swift
//  Cats
//
//  Created by Isabel Couto on 05/07/2025.
//

import SwiftUI

struct CatGridItem: View {
    let cat: Cat

    var body: some View {
           VStack(spacing: 8) {
               // Imagem estática
               Image("demoCat")
                   .resizable()
                   .scaledToFill()
                   .frame(height: 120)
                   .clipped()
                   .cornerRadius(10)

               Text(cat.name)
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
