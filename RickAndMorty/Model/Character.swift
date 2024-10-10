//
//  Character.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 10.10.2024.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let pages: Int
}

struct Character: Codable {
    let name: String
    let gender: String
    let image: String
}
