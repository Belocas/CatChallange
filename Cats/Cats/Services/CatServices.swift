//
//  CatServices.swift
//  Cats
//
//  Created by Isabel Couto on 05/07/2025.
//

import Foundation

final class CatService {
    
    // Endpoint base
    private let baseURL = "https://api.thecatapi.com/v1/breeds?limit="
    
    func fetchCats(limit: Int = 10, page: Int = 0 ,completion: @escaping (Result<[Cat], Error>) -> Void) {
        
        
        guard let url = URL(string: baseURL+limit.description + "&page=" + page.description) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        print("TESTE ISABEL " + url.description)
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let cats = try JSONDecoder().decode([Cat].self, from: data)
                completion(.success(cats))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
