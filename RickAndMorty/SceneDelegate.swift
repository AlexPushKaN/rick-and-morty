//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 10.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowsScene)
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        window.rootViewController = mainCoordinator.navigationController
        mainCoordinator.start()
        window.makeKeyAndVisible()
        self.window = window
    }
}

