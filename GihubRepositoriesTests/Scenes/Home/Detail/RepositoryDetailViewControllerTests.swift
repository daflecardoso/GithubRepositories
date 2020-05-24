//
//  IssueDetailViewControllerTests.swift
//  GihubRepositoriesDafleCardosoTests
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import XCTest
@testable import GihubRepositories

class RepositoryDetailViewControllerTests: XCTestCase {

    func test_view_attributes_data() {
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
        let viewController = RepositoryDetailViewController(viewModel: viewModel)
        UIApplication.shared
            .windows
            .filter {$0.isKeyWindow}
            .first?
            .rootViewController = viewController
        XCTAssertEqual(viewController.webView.url?.absoluteString, "https://google.com.br/")
    }
}
