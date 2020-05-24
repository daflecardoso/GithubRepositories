//
//  GithubServiceMock.swift
//  GihubRepositoriesDafleCardosoTests
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation
import RxSwift
@testable import GithubRepositories

class GithubServiceMock: GithubServiceContract {
    
    private let mockType: MockType
    
    init(with mockType: MockType) {
        self.mockType = mockType
    }
    
    func repositories(query: String, page: Int) -> Single<GithubRepositoryResponse> {
        switch self.mockType {
        case .success:
            return Single.just(GithubRepositoryResponse(totalCount: 4,
                                                        items: [
                GithubRepository(fullName: "apple",
                                 name: "swift",
                                 description: "swift language",
                                 watchers: 1000,
                                 forks: 2000,
                                 owner: GithubOwner(login: "apple",
                                                    avatarUrl: nil)),
                GithubRepository(fullName: "google",
                                 name: "kotlin",
                                 description: "kotlin language",
                                 watchers: 2000,
                                 forks: 4000,
                                 owner: GithubOwner(login: "google",
                                                    avatarUrl: nil))
            ]))
        case .successWith(let jsonFile):
            guard let response: GithubRepositoryResponse = jsonFile.toObject() else {
                return Single.error(ServiceError.default)
            }
            return Single.just(response)
        case .error:
            return Single.error(ServiceError.invalidResponse)
        case .empty:
            return Single.just(GithubRepositoryResponse(totalCount: 0, items: []))
        }
    }
    
    func readmeMd(owner: String, repo: String) -> Single<ReadmeMdResponse> {
        switch self.mockType {
        case .success:
            return Single.just(ReadmeMdResponse(htmlUrl: "https://google.com.br/"))
        case .successWith(jsonFile: let jsonFile):
            guard let response: ReadmeMdResponse = jsonFile.toObject() else {
                return Single.error(ServiceError.default)
            }
            return Single.just(response)
        case .empty:
            return Single.just(ReadmeMdResponse(htmlUrl: nil))
        case .error:
            return Single.error(ServiceError.default)
        }
    }
}
