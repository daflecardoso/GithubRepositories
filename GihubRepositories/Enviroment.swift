//
//  Enviroment.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 14/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation

class Enviroment {
    
    static let baseUrl = Enviroment.pList(key: "BASE_URL")
    
    private static func pList(key: String) -> String {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String ?? ""
    }
}
