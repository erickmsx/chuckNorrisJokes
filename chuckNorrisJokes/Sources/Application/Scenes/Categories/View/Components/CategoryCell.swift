//
//  CategoryCell.swift
//  chuckNorrisJokes
//
//  Created by Erick Martins on 05/01/22.
//

import UIKit

// Pattern DTO -> Data Object Transfer
struct CategoryCellDTO {
    let category: String
}

class CategoryCell: UITableViewCell {
   
    @IBOutlet weak var categoryLabel: UILabel!
    
    func fill(dto: CategoryCellDTO) {
        categoryLabel.text = dto.category
    }
}
