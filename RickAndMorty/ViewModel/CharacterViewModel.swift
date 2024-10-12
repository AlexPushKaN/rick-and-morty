//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 10.10.2024.
//

import Foundation

final class CharacterViewModel {
    let networkManager: NetworkManager
    let character: Character
    var episodes: [Episode] = [] {
        didSet {
            if character.episode.count == episodes.count {
                episodes.forEach { episode in
                    print(episode.name)
                }
            }
        }
    }
    var getPicture: ((Data) -> Void)?
    
    init(service: NetworkManager, item: Character) {
        self.character = item
        self.networkManager = service
    }
    
    func download() {
        networkManager.fetchImage(from: character.image) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data): getPicture?(data)
            case .failure(_): break
            }
        }
        character.episode.forEach { episode in
            networkManager.fetchData(from: .episode(episode)) { [weak self] result in
                guard let self = self else { return }
                if let episode = DataHandler.handle(result: result, for: Episode.self) {
                    episodes.append(episode)
                }
            }
        }
    }
}
