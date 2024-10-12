//
//  ListCharactersViewController.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 10.10.2024.
//

import UIKit

final class ListCharactersViewController: UIViewController {
    
    var viewModel: ListCharactersViewModel!
    var coordinator: MainCoordinator!
    
    var tableView: UITableView!
    let indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    init(viewModel: ListCharactersViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupViewModel()
        viewModel.download()
        
        indicatorView.startAnimating()
    }
    
    private func setupUI() {
        title = "Список персонажей"
        view.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.04682027549, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1),
            .font: UIFont.systemFont(ofSize: 25, weight: .bold)
        ]
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 20.0
        tableView.layer.borderWidth = 5.0
        tableView.layer.borderColor = #colorLiteral(red: 0.9115380049, green: 0.5374680161, blue: 0.9122094512, alpha: 1)
        view.addSubview(tableView)
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.dataSource = viewModel
        tableView.delegate = self
        
        indicatorView.color = #colorLiteral(red: 0, green: 1, blue: 0.04682027549, alpha: 1)
        indicatorView.center = view.center
        view.addSubview(indicatorView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0)
        ])
    }
    
    private func setupViewModel() {
        viewModel.showAlert = {
            let alert = UIAlertController(title: "Ошибка", message: "Вы загрузили все страницы", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        viewModel.updateUI = {
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension ListCharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCharacter = viewModel.selectItem(at: indexPath.row)
        coordinator.showCharacter(for: selectedCharacter)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            indicatorView.startAnimating()
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] timer in
                guard let self = self else { return }
                self.viewModel.currentPage += 1
                self.viewModel.download()
            }
        }
    }
}
