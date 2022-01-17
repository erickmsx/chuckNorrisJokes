//
//  APIService.swift
//  chuckNorrisJokes
//
//  Created by Erick Martins on 05/01/22.
//

import Foundation

class APIService {
    
    private let basePath = "https://api.chucknorris.io/jokes/categories"
    private let jokePath = "https://api.chucknorris.io/jokes/random?category="
    
    func fetchCategories(completion: @escaping ([String]) -> Void) {
        
        URLSession.shared.dataTask(with: URL(string: basePath)!) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            do {
                let categories = try JSONDecoder().decode([String].self, from: data)
                completion(categories)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchJoke(category: String, completion: @escaping (JokeResponse) -> Void) {
        
        URLSession.shared.dataTask(with: URL(string: "\(jokePath)\(category)")!) { data, response, error in

            guard let data = data else {
                return
            }

            do {
                let joke = try JSONDecoder().decode(JokeResponse.self, from: data)
                completion(joke)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
