//
//  HomeViewModel.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    private let githubService: GithubServiceContract
    internal var repositories: [GithubRepository] = []
    
    private let _onFetched = PublishSubject<()>()
    var onFetched: Driver<()> {
        return self._onFetched.asDriver(onErrorJustReturn: ())
    }
    
    private let _isHiddenEmptyView = PublishSubject<Bool>()
    var isHiddenEmptyView: Driver<Bool> {
        return self._isHiddenEmptyView.asDriver(onErrorJustReturn: true)
    }
    
    private var totalCount: Int = 0
    private var query: String = ""
    private var page: Int = 1
    private var isRequesting: Bool = false
    
    init(githubService: GithubServiceContract) {
        self.githubService = githubService
    }
    
    func fetchMoreItems(indexPath: IndexPath) {
        if !self.isRequesting &&
            indexPath.row > (self.repositories.count - 2)
            && self.repositories.count < totalCount {
            
            self.isRequesting = true
            self.page = self.page + 1
            self.fetch(query: self.query)
            print("fetch page \(self.page)")
        }
    }
    
    func fetch(query: String) {
        self.query = query
        guard !self.query.isEmpty else {
            return
        }
        self.githubService
            .repositories(query: self.query, page: self.page)
            .defaultLoading(super.isLoading)
            .subscribe(onSuccess: { response in
                self.totalCount = response.totalCount ?? 0
                self.repositories.append(contentsOf: response.items ?? [])
                self._onFetched.onNext(())
                self.isRequesting = false
                self._isHiddenEmptyView
                    .onNext(self.totalCount > 0 && !self.query.isEmpty)
            }, onError: handleError(error:))
            .disposed(by: disposeBag)
    }
    
    func clearData() {
        self.query = ""
        self.page = 1
        self.isRequesting = false
        self.repositories.removeAll()
        self._onFetched.onNext(())
    }
}

#if DEBUG

/**
 Helper variables for testing
 */
extension HomeViewModel {
    
    var publicTotalCount: Int {
        return self.totalCount
    }
    
    var publicQuery: String {
        return self.query
    }
    
    var publicPage: Int {
        return self.page
    }
    
    var publicIsRequesting: Bool {
        get {
            return self.isRequesting
        }
    }
    
    func setIsRequesting(isRequesting: Bool) {
        self.isRequesting = isRequesting
    }
}

#endif
