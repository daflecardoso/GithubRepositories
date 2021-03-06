//
//  UIViewController+Extension.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var coordinator: AppCoordinator {
        return self.appDelegate.coordinator
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true) {
        self.present(viewController, animated: animated, completion: nil)
    }
}
