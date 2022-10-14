//
//  AppDelegate.swift
//  PotteryUIKit
//
//  Created by Ahmed Khalaf on 08/10/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootViewControler()
        return true
    }
    
    private func setRootViewControler() {
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = PotteryViewController()
        window?.makeKeyAndVisible()
    }

}

