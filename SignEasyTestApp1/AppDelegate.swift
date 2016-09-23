//
//  AppDelegate.swift
//  SignEasyTestApp1
//
//  Created by Chirag Ramani on 22/09/16.
//  Copyright © 2016 Chirag Ramani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window=UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        let layout=UICollectionViewFlowLayout()
        let featuredAppsController = ViewController(collectionViewLayout: layout)
        let windowNavigationController=UINavigationController(rootViewController: featuredAppsController)
        window?.rootViewController=windowNavigationController
        return true
    }
    
    
}

