//
//  ListCharactersViewModel.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 10.10.2024.
//

import UIKit

final class ListCharactersViewModel: NSObject {
    var items: [Character] = [] {
        didSet {
            updateUI?()
        }
    }
    let networkManager: NetworkManager!
    var currentPage: Int = 1
    lazy var numberOfPages: Int = currentPage
    var updateUI: (() -> Void)?
    var showAlert: (() -> Void)?
    
    init(service: NetworkManager) {
        networkManager = service
        super.init()
    }
    
    func download() {
        if currentPage <= numberOfPages {
            networkManager.fetchData(from: .page(currentPage)) { [weak self] result in
                guard let self = self else { return }
                if let response = DataHandler.handle(result: result, for: CharacterResponse.self) {
                    self.items.append(contentsOf: response.results)
                    self.numberOfPages = response.info.pages
                }
            }
        } else {
            showAlert?()
        }
    }
    
    func selectItem(at index: Int) -> Character {
        return items[index]
    }
}

// MARK: - UITableViewDataSource
extension ListCharactersViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
        networkManager.fetchImage(from: items[indexPath.row].image) { result in
            DispatchQueue.main.async {
                if let visibleIndexPath = tableView.indexPath(for: cell), visibleIndexPath == indexPath {
                    switch result {
                    case .success(let data): cell.pictureImageView.image = UIImage(data: data)
                    case .failure(_): break
                    }
                }
            }
        }
        cell.nameLabel.text = items[indexPath.row].name
        cell.genderLabel.text = items[indexPath.row].gender
        return cell
    }
}
