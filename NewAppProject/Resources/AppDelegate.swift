//
//  AppDelegate.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 07/03/23.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.splashScreen()
        IQKeyboardManager.shared.enable = true
        DataBaseManager.shared.createDatabse()
        return true
    }

  
    // MARK: UISceneSession Lifecycle

    
    
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate{
    private func splashScreen(){
        let launchScreenVC = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
        
        let rootVC = launchScreenVC.instantiateViewController(identifier: "splashController")
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(dismissSplashController), userInfo: nil, repeats: false)
    }
    
    @objc func dismissSplashController(){
        let mainVC = UIStoryboard.init(name: "Main", bundle: nil)
        let rootVC = mainVC.instantiateViewController(identifier: "initController")
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }
}
