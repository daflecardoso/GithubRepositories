//
//  AppDelegate.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 14/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var coordinator: AppCoordinator = AppCoordinator(appDelegate: self, window: window!)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setup()
        return true
    }
    
    private func setup() {
        self.window = UIWindow()
        self.coordinator.start()
    }
}

