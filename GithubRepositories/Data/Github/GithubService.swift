//
//  GithubService.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol GithubServiceContract {
    func repositories(query: String, page: Int) -> Single<GithubRepositoryResponse>
    func readmeMd(owner: String, repo: String) -> Single<ReadmeMdResponse>
}

class GithubService: GithubServiceContract {
    
    private let provider = ApiProvider<GithubApi>()
    
    func repositories(query: String, page: Int) -> Single<GithubRepositoryResponse> {
        return self.provider.rx.request(.repositories(query, page))
            .mapDefault(GithubRepositoryResponse.self)
    }
    
    func readmeMd(owner: String, repo: String) -> Single<ReadmeMdResponse> {
        return self.provider.rx.request(.readmeMD(owner, repo))
            .mapDefault(ReadmeMdResponse.self)
    }
}
