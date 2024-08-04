//
//  SceneDelegate.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let coreDataStack = CoreDataStack.instance
    let worker = ApplicationWorker.instance


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .cardBackground
        appearance.shadowColor = .cardBackground
        let hasJoined = worker.hasUserAlreadyJoined()
        let controller = hasJoined ? GymTabBarController(): AuthenticationViewController()
        let rootViewController = LightStatusNavigationController(rootViewController: controller)
        rootViewController.navigationBar.standardAppearance = appearance
        rootViewController.navigationBar.scrollEdgeAppearance = appearance
        rootViewController.navigationBar.compactScrollEdgeAppearance = appearance
        rootViewController.navigationBar.tintColor = .white
        rootViewController.navigationBar.barTintColor = .white
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        coreDataStack.saveContext()
    }
}

