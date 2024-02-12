//
//  SceneDelegate.swift
//  3Kick_tableview
//
//  Created by Нечаев Михаил on 11.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        let nc = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }

}

