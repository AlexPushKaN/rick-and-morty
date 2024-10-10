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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.view.backgroundColor = .blue
    }

    func start() {
        let listCharactersViewModel = ListCharactersViewModel()
        let listCharactersViewController = ListCharactersViewController(viewModel: listCharactersViewModel)
        listCharactersViewController.coordinator = self
        navigationController.pushViewController(listCharactersViewController, animated: true)
    }

    func showDetail(for item: Character) {
        let characterViewModel = CharacterViewModel(item: item)
        let characterViewController = CharacterViewController(viewModel: characterViewModel)
        navigationController.pushViewController(characterViewController, animated: true)
    }
}
