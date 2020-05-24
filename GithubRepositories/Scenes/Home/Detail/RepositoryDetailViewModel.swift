//
//  IssueDetailViewModel.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RepositoryDetailViewModel: BaseViewModel {
    
    internal let repository: GithubRepository
    private let githubService: GithubServiceContract
    
    private let _urlWebView = PublishSubject<URLRequest?>()
    var urlWebView: Driver<URLRequest?> {
        return self._urlWebView.asDriver(onErrorJustReturn: nil)
    }
    
    init(githubService: GithubServiceContract, repository: GithubRepository) {
        self.githubService = githubService
        self.repository = repository
    }
    
    func fetch() {
        self.githubService
            .readmeMd(owner: self.repository.owner?.login ?? "",
                      repo: self.repository.name ?? "")
            .defaultLoading(super.isLoading)
            .subscribe(onSuccess: { response in
                guard let url = URL(string: response.htmlUrl ?? "") else {
                    return self.handleError(error: ServiceError.default)
                }
                self._urlWebView.onNext(URLRequest(url: url))
            }, onError: handleError(error:))
            .disposed(by: disposeBag)
    }
}
