//
//  RepositoryDetailViewModelTest.swift
//  GihubRepositoriesTests
//
//  Created by Dafle Cardoso on 24/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import XCTest
import RxSwift
@testable import GihubRepositories

class RepositoryDetailViewModelTest: XCTestCase {
    
    private let disposeBag = DisposeBag()
    
    func test_fetch_readme_success_data() {
        let repositoy = GithubRepository(fullName: "apple",
                                         name: "swift",
                                         description: "swift language",
                                         watchers: 1000,
                                         forks: 2000,
                                         owner: GithubOwner(login: "apple",
                                                            avatarUrl: nil))
        let service = GithubServiceMock(with: .success)
        let viewModel = RepositoryDetailViewModel(githubService: service,
                                                  repository: repositoy)
        var urlRequest: URLRequest!
        
        viewModel.urlWebView.drive(onNext: { _urlRequest in
            urlRequest = _urlRequest
        }).disposed(by: disposeBag)
        
        viewModel.fetch()
        
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://google.com.br/")
    }
    
    func test_fetch_with_error() {
        let repositoy = GithubRepository(fullName: "apple",
                                         name: "swift",
                                         description: "swift language",
                                         watchers: 1000,
                                         forks: 2000,
                                         owner: GithubOwner(login: "apple",
                                                            avatarUrl: nil))
        let service = GithubServiceMock(with: .error)
        let viewModel = RepositoryDetailViewModel(githubService: service,
                                                  repository: repositoy)
        var urlRequest: URLRequest!
        
        viewModel.urlWebView.drive(onNext: { _urlRequest in
            urlRequest = _urlRequest
        }).disposed(by: disposeBag)
        
        viewModel.fetch()
        
        XCTAssertNil(urlRequest)
    }
}
