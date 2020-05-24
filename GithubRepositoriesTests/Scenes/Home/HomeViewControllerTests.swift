//
//  HomeViewControllerTests.swift
//  GihubRepositoriesDafleCardosoTests
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import XCTest
import RxSwift
@testable import GithubRepositories

class HomeViewControllerTests: XCTestCase {
    
    private let disposeBag = DisposeBag()
    
    func test_number_of_lines_in_table_view() {
        let viewModel = HomeViewModel(githubService: GithubServiceMock(with: .success))
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.fetch(query: "swift")
        UIApplication.shared
            .windows
            .filter {$0.isKeyWindow}
            .first?
            .rootViewController = viewController
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 2)
        XCTAssertEqual(viewController.emptyView.isHidden, true)
    }
    
    func test_number_of_lines_in_tableview_with_empty_data() {
        let viewModel = HomeViewModel(githubService: GithubServiceMock(with: .empty))
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.fetch(query: "swift")
        UIApplication.shared
            .windows
            .filter {$0.isKeyWindow}
            .first?
            .rootViewController = viewController
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_number_of_lines_in_tableview_with_error() {
        let viewModel = HomeViewModel(githubService: GithubServiceMock(with: .error))
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.fetch(query: "swift")
        UIApplication.shared
            .windows
            .filter {$0.isKeyWindow}
            .first?
            .rootViewController = viewController
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(viewController.emptyView.isHidden, true)
    }
    
    func test_fetch_more_data() {
        let viewModel = HomeViewModel(githubService: GithubServiceMock(with: .success))
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.fetch(query: "swift")
        UIApplication.shared
            .windows
            .filter {$0.isKeyWindow}
            .first?
            .rootViewController = viewController
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 2)
        
        viewModel.fetchMoreItems(indexPath: IndexPath(row: 2, section: 0))
        
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 4)
        XCTAssertEqual(viewController.emptyView.isHidden, true)
    }
}
