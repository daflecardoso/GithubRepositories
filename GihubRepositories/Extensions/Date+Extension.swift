//
//  Date+Extension.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation

extension Date {
    
    func ddMMyyyyHHmmss() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy 'às' HH:mm:ss"
        return dateFormater.string(from: Date())
    }
}
