//
//  String+Extension.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation

extension String {
    
    var url: URL {
        guard let url = URL(string: self) else {
            fatalError("This string \(self) cannot be a URL")
        }
        return url
    }
    
    func toObject<T: Decodable>() -> T? {
        let data = Bundle.main.dataFromJsonFile(name: self)
        return try? JSONDecoder.default.decode(T.self, from: data)
    }
}
