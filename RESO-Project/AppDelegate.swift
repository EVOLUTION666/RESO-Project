//
//  AppDelegate.swift
//  RESO-Project
//
//  Created by Andrey on 04.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.coordinateSpace.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainModuleBuilder.buildMainModule())
        window?.makeKeyAndVisible()
        
        return true
    }
}

