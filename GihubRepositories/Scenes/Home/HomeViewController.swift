//
//  HomeViewController.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    override var baseViewModel: BaseViewModelContract? {
        return self.viewModel
    }
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        self.setupTableView()
        self.setupSearchView()
    }
    
    private func setupSearchView() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Pesquisar"
        searchController.searchBar.delegate = self
        searchController.searchBar.accessibilityIdentifier = "repository-search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupTableView() {
        self.title = "Repositórios"
        view.accessibilityIdentifier = "Main View"
        self.tableView.register(cellType: HomeCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel
            .onFetched
            .drive(onNext: { [unowned self] in
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func repository(indexPath: IndexPath) -> GithubRepository {
        return self.viewModel.repositories[indexPath.row]
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let repository = self.repository(indexPath: indexPath)
        let viewController = self.coordinator.makeIssueDetailViewController(repository: repository)
        self.push(viewController)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: HomeCell.self, for: indexPath)
        cell.set(with: self.repository(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel.fetchMoreItems(indexPath: indexPath)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.viewModel.clearData()
        self.viewModel.fetch(query: searchBar.text!)
    }
}
