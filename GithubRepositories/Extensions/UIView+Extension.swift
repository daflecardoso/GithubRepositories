//
//  UIView+Extension.swift
//  GihubRepositories
//
//  Created by Dafle Cardoso on 24/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    // swiftlint:disable force_cast
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
