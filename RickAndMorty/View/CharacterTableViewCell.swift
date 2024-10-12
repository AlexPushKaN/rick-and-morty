//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 11.10.2024.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    static let identifier = String(describing: CharacterTableViewCell.self)
    
    var pictureImageView: UIImageView = UIImageView()
    var nameLabel: UILabel = UILabel()
    var genderLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        pictureImageView.image = nil
        nameLabel.text = ""
        genderLabel.text = ""
    }
    
    private func setupUI() {

        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        pictureImageView.contentMode = .scaleAspectFill
        pictureImageView.layer.cornerRadius = 8.0
        pictureImageView.layer.masksToBounds = true
        pictureImageView.image = UIImage(systemName: "person.crop.circle")
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        genderLabel.textColor = .gray
        
        contentView.addSubview(pictureImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pictureImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            pictureImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            pictureImageView.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.leadingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),

            genderLabel.leadingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: 10),
            genderLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            genderLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            genderLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
