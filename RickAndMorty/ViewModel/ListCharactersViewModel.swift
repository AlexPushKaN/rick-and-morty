//
//  ListCharactersViewModel.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 10.10.2024.
//

import Foundation

class ListCharactersViewModel {
    var items: [Character] = []

    func selectItem(at index: Int) -> Character {
        return items[index]
    }
}
