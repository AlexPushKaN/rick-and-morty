//
//  MainCoordinator.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 10.10.2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    let networkManager = NetworkManager()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let listCharactersViewModel = ListCharactersViewModel(service: networkManager)
        let listCharactersViewController = ListCharactersViewController(viewModel: listCharactersViewModel)
        listCharactersViewController.coordinator = self
        navigationController.pushViewController(listCharactersViewController, animated: true)
    }

    func showCharacter(for item: Character) {
        let characterViewModel = CharacterViewModel(service: networkManager, item: item)
        let characterViewController = CharacterViewController(viewModel: characterViewModel)
        navigationController.pushViewController(characterViewController, animated: true)
    }
}
