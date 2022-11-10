//
//  AppDelegate.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ListOfUniversitiesView())
        window?.makeKeyAndVisible()
        return true
    }
}
