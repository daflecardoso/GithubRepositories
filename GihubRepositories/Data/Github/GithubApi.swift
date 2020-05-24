//
//  GithubApi.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 14/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation
import Moya

enum GithubApi {
    case repositories(String, Int)
    case readmeMD(String, String)
}

extension GithubApi: TargetType {
    
    var baseURL: URL {
        return Enviroment.baseUrl.url
    }
    
    var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        case .readmeMD(let owner, let repo):
            return "/repos/\(owner)/\(repo)/readme"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .repositories:
            return .get
        case .readmeMD:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .repositories:
            return Bundle.main.dataFromJsonFile(name: "mock_repositories_response_success")
        case .readmeMD:
            return Bundle.main.dataFromJsonFile(name: "mock_issues_response_sucess_moya")
        }
    }
    
    var task: Task {
        switch self {
        case .repositories(let query, let page):
            return .requestParameters(parameters: [
                "q": query,
                "page": page,
                "per_page": 20
            ], encoding: URLEncoding.queryString)
        case .readmeMD:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
