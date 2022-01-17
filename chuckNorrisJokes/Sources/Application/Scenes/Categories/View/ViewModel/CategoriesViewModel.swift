//
//  CategoriesViewModel.swift
//  chuckNorrisJokes
//
//  Created by Erick Martins on 05/01/22.
//

import Foundation

protocol CategoriesViewModelDelegate: AnyObject {
    func didLoad()
    func sendCategory(_ category: String)
}

class CategoriesViewModel {
    
    private var categories: [String] = []
    private weak var delegate: CategoriesViewModelDelegate?
    
    init(delegate: CategoriesViewModelDelegate) {
        self.delegate = delegate
    }
    
    func loadCategories() {
        APIService().fetchCategories { [weak self] result in
            
            guard let self = self else { return }
            
            self.categories = result
            self.delegate?.didLoad()
            return
        }
    }
    
    func numberOfSection() -> Int {
        1
    }
    
    func numberOfRows() -> Int {
        categories.count
    }

    func dtoForRows(index: Int) -> CategoryCellDTO {
        let category = categories[index]
        return CategoryCellDTO(category: category)
    }
    
    func selectedJoke(index: Int) {
        let category = categories[index]
        delegate?.sendCategory(category)
    }
}
