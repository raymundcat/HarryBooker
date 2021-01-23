//
//  SceneDelegate.swift
//  HarryBooker
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import QueryTableScreen

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        /// Setting up the Query Table as our
        /// landing ViewController
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = QueryTableViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}

