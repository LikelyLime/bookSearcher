//
//  AppDelegate.swift
//  bookSercher
//
//  Created by 백시훈 on 8/2/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: RootViewController())
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

    


}

