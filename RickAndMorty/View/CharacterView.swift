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
        return viewImage
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = dataCharacter.name
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = dataCharacter.status
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.text = dataCharacter.species
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = dataCharacter.type
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.text = dataCharacter.gender
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var originLabel: UILabel = {
        let label = UILabel()
        label.text = dataCharacter.origin.name
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = dataCharacter.location.name
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.text = dataCharacter.episode.first
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var createdLabel: UILabel = {
        let label = UILabel()
        label.text = dataCharacter.created
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(data: Character) {
        self.dataCharacter = data
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 20.0
        layer.borderWidth = 5.0
        layer.borderColor = #colorLiteral(red: 0.3412324488, green: 0.9804162383, blue: 0.02909816429, alpha: 1)
        
        addSubview(pictureViewImage)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(speciesLabel)
        addSubview(typeLabel)
        addSubview(genderLabel)
        addSubview(originLabel)
        addSubview(locationLabel)
        addSubview(episodeLabel)
        addSubview(createdLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            pictureViewImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            pictureViewImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            pictureViewImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            nameLabel.topAnchor.constraint(equalTo: pictureViewImage.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            speciesLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            speciesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            typeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 8),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            genderLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
            genderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            originLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            originLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            locationLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            episodeLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            episodeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            createdLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 8),
            createdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            createdLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
}
