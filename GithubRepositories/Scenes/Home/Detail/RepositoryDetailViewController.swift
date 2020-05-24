//
//  IssueDetailViewController.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import UIKit
import WebKit

class RepositoryDetailViewController: BaseViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override var baseViewModel: BaseViewModelContract? {
        return self.viewModel
    }
    
    private let viewModel: RepositoryDetailViewModel
    
    init(viewModel: RepositoryDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.viewModel.fetch()
    }
    
    private func setup() {
        self.title = self.viewModel.repository.fullName
        self.viewModel
            .urlWebView
            .drive(onNext: { [unowned self] urlRequest in
                guard let urlRequest = urlRequest else {
                    return
                }
                self.webView.load(urlRequest)
            }).disposed(by: disposeBag)
    }
}
