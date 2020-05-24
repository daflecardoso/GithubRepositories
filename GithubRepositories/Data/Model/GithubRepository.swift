//
//  GithubIssue.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation

struct GithubRepositoryResponse: Decodable {
    let totalCount: Int?
    let items: [GithubRepository]?
}

struct GithubRepository: Decodable {
    let fullName: String?
    let name: String?
    let description: String?
    let watchers: Int?
    let forks: Int?
    let owner: GithubOwner?
    
    var starsFormatted: String {
        guard let watchers = self.watchers else {
            return ""
        }
        return "★ \(watchers.abbreviated)"
    }
    
    var forksFormatted: String {
        guard let forks = self.forks else {
            return ""
        }
        return "🍴 \(forks.abbreviated)"
    }
}

struct GithubOwner: Decodable {
    let login: String?
    let avatarUrl: String?
}
