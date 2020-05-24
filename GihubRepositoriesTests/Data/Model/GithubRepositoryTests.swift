//
//  GithubIssueTests.swift
//  GihubRepositoriesDafleCardosoTests
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import XCTest
@testable import GihubRepositories

class GithubRepositoryTests: XCTestCase {

    func test_methods_data_object_and_helpers() {
        let owner = GithubOwner(login: "apple", avatarUrl: "http://user-image.com")
        let repository = GithubRepository(fullName: "Dafle Cardoso",
                                     name: "apple",
                                     description: "swift",
                                     watchers: 1000,
                                     forks: 2000,
                                     owner: owner)
        
        XCTAssertEqual(repository.starsFormatted, "★ 1K")
        XCTAssertEqual(repository.forksFormatted, "🍴 2K")
    }
}
