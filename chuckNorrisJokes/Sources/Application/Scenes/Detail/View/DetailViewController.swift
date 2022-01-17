//
//  DetailViewController.swift
//  chuckNorrisJokes
//
//  Created by Erick Martins on 05/01/22.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var jokeLabel: UILabel!
    
    private lazy var viewModel: DetailViewModel = DetailViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setup(_ category: String) {
        viewModel.setup(category)
    }
}

private extension DetailViewController {
    
    func setupView() {
        hideComponents()
    }
    
    func fill() {
        let url = URL(string: viewModel.joke.iconUrl ?? "")
        imageView.kf.setImage(with: url)
        jokeLabel.text = viewModel.joke.value
    }
    
    func hideComponents() {
        imageView.isHidden = true
        jokeLabel.isHidden = true
        view.lock()
    }
    
    func showComponents() {
        imageView.isHidden = false
        jokeLabel.isHidden = false
        view.unlock()
    }
    
    func setupNavBar() {
        navigationItem.title = viewModel.joke.categories?[0]
    }
}

extension DetailViewController: DetailViewModelDelegate {
    
    func didLoad() {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.fill()
            self.setupNavBar()
            self.showComponents()
        }
    }
}
