//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 11.10.2024.
//

import UIKit

class CharacterView: UIView {
    
    var dataCharacter: Character
    
    lazy var pictureViewImage: UIImageView = {
        let viewImage = UIImageView()
        viewImage.image = UIImage(systemName: "person.crop.circle")
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        viewImage.layer.cornerRadius = 15.0
        viewImage.clipsToBounds = true
        return viewImage
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var originLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var episodeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.layer.cornerRadius = 15.0
        tableView.layer.borderColor = #colorLiteral(red: 0.900549233, green: 0.9478096366, blue: 0.9716048837, alpha: 1).cgColor
        tableView.layer.borderWidth = 2.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "episodeCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var createdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let lineNames: [(String, UIView)] = [
            ("Имя", nameLabel),
            ("Статус", statusLabel),
            ("Вид", speciesLabel),
            ("Тип", typeLabel),
            ("Пол", genderLabel),
            ("Место рождения", originLabel),
            ("Место нахождения", locationLabel),
            ("Список эпизодов", UIView())
        ]
        
        let verticalStackView = UIStackView(arrangedSubviews: [])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        lineNames.forEach { key, value in
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .caption1)
            label.text = key
            let horizontalStackView = UIStackView(arrangedSubviews: [label, value])
            horizontalStackView.distribution = .fillEqually
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
        
        verticalStackView.addArrangedSubview(episodeTableView)
        
        return verticalStackView
    }()
    
    init(data: Character) {
        self.dataCharacter = data
        super.init(frame: .zero)
        setupView()
        populateData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 20.0
        layer.borderWidth = 5.0
        layer.borderColor = #colorLiteral(red: 0, green: 0.9712186456, blue: 0.03767263144, alpha: 1)
        
        addSubview(pictureViewImage)
        addSubview(stackView)
        addSubview(createdLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pictureViewImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            pictureViewImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            pictureViewImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: pictureViewImage.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            createdLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            createdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            createdLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            episodeTableView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func populateData() {
        nameLabel.text = dataCharacter.name
        statusLabel.text = dataCharacter.status
        speciesLabel.text = dataCharacter.species
        typeLabel.text = dataCharacter.type.isEmpty ? "не известно" : dataCharacter.type
        genderLabel.text = dataCharacter.gender
        originLabel.text = dataCharacter.origin.name
        locationLabel.text = dataCharacter.location.name
        createdLabel.text = "Создан - \(DataHandler.format(dateString: dataCharacter.created) ?? "не известно")"
    }
}

// MARK: - UITableViewDataSource
extension CharacterView: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataCharacter.episode.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        cell.textLabel?.text = dataCharacter.episode[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CharacterView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30.0
    }
}
