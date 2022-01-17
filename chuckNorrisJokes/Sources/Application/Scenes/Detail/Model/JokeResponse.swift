//
//  JokeResponse.swift
//  chuckNorrisJokes
//
//  Created by Erick Martins on 05/01/22.
//

import Foundation

struct JokeResponse: Codable {
    let categories: [String]?
    let iconUrl: String?
    let value: String?
}

extension JokeResponse {
    enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url"
        case value
        case categories
    }
}
