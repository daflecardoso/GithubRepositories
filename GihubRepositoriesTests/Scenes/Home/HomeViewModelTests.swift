//
//  HomeViewModelTests.swift
//  GihubRepositoriesDafleCardosoTests
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import XCTest
import RxSwift
@testable import GihubRepositories

class HomeViewModelTests: XCTestCase {
    
    private let disposeBag = DisposeBag()
    
    func test_fetch_repositories_success() {
        let viewModel = HomeViewModel(githubService: GithubServiceMock(with: .success))
        
        viewModel.fetch(query: "swift")
        
        let repositories = viewModel.repositories
        
        XCTAssertEqual(repositories.count, 2)
        let issue = repositories.first!
        XCTAssertEqual(issue.fullName, "apple")
        XCTAssertEqual(issue.name, "swift")
        XCTAssertEqual(issue.description, "swift language")
        XCTAssertEqual(issue.watchers, 1000)
        XCTAssertEqual(issue.forks, 2000)
        XCTAssertEqual(issue.owner?.login, "apple")
        XCTAssertNil(issue.owner?.avatarUrl)
        
        XCTAssertEqual(viewModel.publicTotalCount, 4)
        XCTAssertEqual(viewModel.publicQuery, "swift")
        XCTAssertEqual(viewModel.publicPage, 1)
        XCTAssertEqual(viewModel.publicIsRequesting, false)
    }
    
    func test_api_isnot_called_with_empty_query() {
        let viewModel = HomeViewModel(githubService: GithubServiceMock(with: .success))
        
        viewModel.fetch(query: "")
        
        let repositories = viewModel.repositories
        
        XCTAssertNil(repositories.first)
    }
    
    func test_fetch_and_receive_empty_data() {
        let viewModel = HomeViewModel(githubService: GithubServiceMock(with: .empty))
        
        let repositories = viewModel.repositories
        
        viewModel.fetch(query: "swift")
        
        XCTAssertEqual(repositories.count, 0)
    }
    
    func test_fetch_repositories_and_receive_error() {
        let viewModel = HomeViewModel(githubService: GithubServiceMock(with: .error))
        
        viewModel.fetch(query: "swift")
        
        let repositories = viewModel.repositories
        
        XCTAssertEqual(repositories.count, 0)
    }
    
    func test_fetch_repositories_with_json_file() {
        let mockService = GithubServiceMock(with: .successWith(jsonFile: "mock_repositories_response_success"))
        let viewModel = HomeViewModel(githubService: mockService)
        
        viewModel.fetch(query: "any string")
        
        let repositories = viewModel.repositories
        
        XCTAssertEqual(repositories.count, 30)
        let issue = repositories.first!
        XCTAssertEqual(issue.fullName, "apple/swift")
        XCTAssertEqual(issue.name, "swift")
        XCTAssertEqual(issue.description, "The Swift Programming Language")
        XCTAssertEqual(issue.watchers, 51749)
        XCTAssertEqual(issue.forks, 8409)
        XCTAssertEqual(issue.owner?.login, "apple")
        XCTAssertEqual(issue.owner?.avatarUrl, "https://avatars0.githubusercontent.com/u/10639145?v=4")
    }
    
    func test_fetch_more_data() {
        let viewModel = HomeViewModel(githubService: GithubServiceMock(with: .success))
        
        viewModel.fetch(query: "swift")
        
        XCTAssertEqual(viewModel.repositories.count, 2)
        
        XCTAssertEqual(viewModel.publicTotalCount, 4)
        XCTAssertEqual(viewModel.publicQuery, "swift")
        XCTAssertEqual(viewModel.publicPage, 1)
        XCTAssertEqual(viewModel.publicIsRequesting, false)
        
        viewModel.setIsRequesting(isRequesting: false)
        viewModel.fetchMoreItems(indexPath: IndexPath(row: 2, section: 0))
        
        XCTAssertEqual(viewModel.repositories.count, 4)
        
        XCTAssertEqual(viewModel.publicTotalCount, 4)
        XCTAssertEqual(viewModel.publicQuery, "swift")
        XCTAssertEqual(viewModel.publicPage, 2)
        XCTAssertEqual(viewModel.publicIsRequesting, false)
    }
}
