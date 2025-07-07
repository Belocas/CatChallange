//
//  CatServices.swift
//  Cats
//
//  Created by Isabel Couto on 05/07/2025.
//

import Foundation

final class CatService {
    
    // Endpoint base
    private let baseURL = "https://api.thecatapi.com/"
    private let fetchCats = "v1/breeds?limit="
    private let fetchImageCat = "v1/images/"
    
    func fetchCats(limit: Int = 10, page: Int = 0 ,completion: @escaping (Result<[Cat], Error>) -> Void) {
        
        
        guard let url = URL(string: baseURL + fetchCats.description + limit.description + "&page=" + page.description) else {
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
    
    
    func fetchCatImage(idCat:String , completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: baseURL + fetchImageCat.description + idCat) else {
            completion(.failure(URLError(.badURL)))
            return
        }
                
        var request = URLRequest(url: url)
        request.setValue("x-api-key", forHTTPHeaderField: "live_7rFyQRr9Un7bQMJn9AmjmrSv2wvfEfvwH6yvu46HCE8P6JOtu1ehZMH18Y6phgUk") //TODO: SAVE THE KEY IN SAFETY MODE
        
        
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
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let imageURL = json["url"] as? String {
                    print("Valor:", imageURL)
                    completion(.success(imageURL))
                } else {
                    completion(.failure(URLError(.cannotParseResponse)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
}
