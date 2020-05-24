//
//  MockType.swift
//  GihubRepositoriesDafleCardosoTests
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation

enum MockType {
    case success
    case successWith(jsonFile: String)
    case empty
    case error
}
