//
//  CatDetailView.swift
//  Cats
//
//  Created by Isabel Couto on 07/07/2025.
//

import SwiftUI

struct CatDetailView: View {
    @StateObject private var viewModel: CatDetailsViewModel

    init(cat: Cat) {
        _viewModel = StateObject(wrappedValue: CatDetailsViewModel(cat: cat))
    }

    var body: some View {
        VStack(spacing: 16) {

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
                            .frame(height: 400)
                            .clipped()
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 400)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)
                    .foregroundColor(.gray)
            }
           
        }
        .padding()
        .navigationTitle(viewModel.name)
        
        
        ScrollView {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .firstTextBaseline) {
                  Text("breed_name_label").bold() + Text(viewModel.name)
              }
            
            HStack(alignment: .top) {
                   Text("origin_label").bold() + Text(viewModel.origin)
               }
               HStack(alignment: .top) {
                   Text("temperament_label").bold() + Text(viewModel.temperament)
               }
               HStack(alignment: .top) {
                   Text("description_label").bold() +
                   Text(viewModel.description)
               }
        }
        .padding(.horizontal)
        .font(.body)
    
    }
                                }}
