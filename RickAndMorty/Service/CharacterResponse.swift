//
//  CharacterResponse.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 11.10.2024.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
