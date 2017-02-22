//
//  AppDelegate.swift
//  Hannah
//
//  Created by Evandro Harrison Hoffmann on 2/21/17.
//  Copyright © 2017 Evandro Harrison Hoffmann. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //start libraries
        startLibraries(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        MVAwesomeDataHelper.saveContext()
    }

}

// Library usage

extension AppDelegate {
    
    func startLibraries(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        // AwesomeData
        MVAwesomeDataHelper.start()
        
        MVLocalNotificationsHelper.enableLocalNotifications(withApplication: application)
    }
    
}


