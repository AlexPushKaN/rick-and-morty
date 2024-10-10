//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Александр Муклинов on 10.10.2024.
//

import UIKit

class CharacterViewController: UIViewController {
    
    var viewModel: CharacterViewModel!
    
    init(viewModel: CharacterViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
