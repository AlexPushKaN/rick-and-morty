//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 10.10.2024.
//

import UIKit

final class CharacterViewController: UIViewController {
    private let viewModel: CharacterViewModel
    private lazy var characterView: CharacterView = CharacterView(data: viewModel.character)
    
    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterView.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.864523828, green: 0.5083928108, blue: 0.8624697328, alpha: 1)
        view.addSubview(characterView)
        
        setupConstraints()
        viewModel.getPicture = { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.characterView.pictureViewImage.image = UIImage(data: data)
            }
        }
        viewModel.download()
        viewModel.updateTableView = { [weak self] updateCharacter in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.characterView.dataCharacter = updateCharacter
                self.characterView.episodeTableView.reloadData()
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            characterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            characterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            characterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0)
        ])
    }
}
