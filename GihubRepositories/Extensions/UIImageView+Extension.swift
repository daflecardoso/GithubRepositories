//
//  UIImageView+Extension.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func loadFrom(url imageUrl: String?, placeHolder: String = "nouser") {
        let placeHolder = UIImage(named: placeHolder)
        guard let imageUrl = imageUrl else {
            self.image = placeHolder
            return
        }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: imageUrl),
                         placeholder: placeHolder,
                         options: nil, progressBlock: nil) { result in
            switch result {
            case .success: break
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
