//
//  CategoriesViewController.swift
//  chuckNorrisJokes
//
//  Created by Erick Martins on 05/01/22.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel: CategoriesViewModel = CategoriesViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension CategoriesViewController {
    
    func setup() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.register(CategoryCell.self)
        viewModel.loadCategories()
        setupNavBar()
    }
    
    func setupNavBar() {
        navigationItem.title = "Categories"
    }
    
    func cell(_ tableView: UITableView, indexPath: IndexPath, categoryDTO: CategoryCellDTO) -> UITableViewCell {
        
        let cell = tableView.dequeCell(CategoryCell.self, indexPath)
        cell.fill(dto: categoryDTO)
        
        cell.selectionStyle = .none
        return cell
    }
}

extension CategoriesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cell(tableView, indexPath: indexPath, categoryDTO: viewModel.dtoForRows(index: indexPath.row))
    }
}

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedJoke(index: indexPath.row)
    }
}

extension CategoriesViewController: CategoriesViewModelDelegate {
    
    func didLoad() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func sendCategory(_ category: String) {
        
        let detailViewController = DetailViewController()
        detailViewController.setup(category)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
