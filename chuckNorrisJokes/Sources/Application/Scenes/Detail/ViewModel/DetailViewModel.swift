//
//  DetailViewModel.swift
//  chuckNorrisJokes
//
//  Created by Erick Martins on 05/01/22.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    
    func didLoad()
}

class DetailViewModel {
    
    private var jokeResponse: JokeResponse?
    private var category: String?
    private weak var delegate: DetailViewModelDelegate?
    
    var joke: JokeResponse {
        
        return jokeResponse ?? JokeResponse(categories: [],
                                            iconUrl: "",
                                            value: "")
    }
    
    init(delegate: DetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func setup(_ category: String) {
        
        self.category = category
        loadJoke(category)
    }
    
    func loadJoke(_ category: String) {
        
        APIService().fetchJoke(category: category) { [weak self] result in
            guard let self = self else { return }
            
            self.jokeResponse = result
            self.delegate?.didLoad()
        }
    }
}
