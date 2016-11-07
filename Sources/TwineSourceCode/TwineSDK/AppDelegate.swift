
//
//  AppDelegate.swift
//  TWRSwiftSDK
//
//  Created by JP Mohler on 4/22/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

import UIKit
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        TwineSignalManager.shared().token = "F3zm2tAvr7+Aei5G6QCD15Osr/ifXHrnFswJ6eSACRk="
        
        self.window!.tintColor = UIColor(red: 38/255, green: 36/255, blue: 96/255, alpha: 1.0)
        

        let defaults = UserDefaults.standard
        
        UserDefaults.standard.set("0Trxr8UTuo44lJbVIlfTp7RYGemeqqkoa40LG3JB", forKey: "twineToken")
        UserDefaults.standard.set("Twine.sampleapp", forKey: "twineKey")
        
        defaults.set("https://lo1dh955ug.execute-api.us-west-2.amazonaws.com/dev", forKey: "behavioralEndpoint")
        defaults.set("https://yxdulxejyd.execute-api.us-west-2.amazonaws.com/dev", forKey: "demographicsEndpoint")
        defaults.set("https://28ull615gk.execute-api.us-west-2.amazonaws.com/dev", forKey: "locationEndpoint")
        defaults.set("https://vl6bsrwbf1.execute-api.us-west-2.amazonaws.com/dev", forKey: "identityEndpoint")
        defaults.set("https://s6emqs9sr9.execute-api.us-west-2.amazonaws.com/dev", forKey: "dHHCEndpoint")
        
        defaults.synchronize()

        return true
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
