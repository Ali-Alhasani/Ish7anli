//
//  AppDelegate.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/10/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import Firebase
import UserNotifications
import AudioToolbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
 let gcmMessageIDKey = "gcm.message_id"
    func reset() {
         move()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.white
      UINavigationBar.appearance().tintColor = UIColor.black
        
        // UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
         FirebaseApp.configure()
        // UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.blue]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "DroidSansArabic", size: 17)!,NSAttributedStringKey.foregroundColor: UIColor(named: "niceBlue")]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "DroidSansArabic", size: 17)!], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "DroidSansArabic", size: 11)!], for: .normal)
        
       
        UITextField.appearance().font = UIFont(name: "DroidSansArabic", size:14)
         MOLH.shared.activate(true)
        move()
        GMSServices.provideAPIKey("AIzaSyAoBkqb_umUq2mUzKD-y_Z299XtBLjqPnM")

        IQKeyboardManager.sharedManager().enable = true

        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        Messaging.messaging().delegate = self
        
        
        application.registerForRemoteNotifications()
        registerForPushNotifications()
        return true
    }
    
    func move(){
        SessionManager.loadSessionManager()
        if (SessionManager.shared.isUserLogged) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        let rightViewController = storyboard.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
        if MOLHLanguage.isRTL() {
            let slideMenuController = SlideMenuController(mainViewController: mainViewController, rightMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
        }else {
            let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: rightViewController)
            self.window?.rootViewController = slideMenuController
            
            
        }
        self.window?.makeKeyAndVisible()
        SlideMenuOptions.contentViewScale = 1.0
        }
        if (SessionManager.shared.isCaptainLogged) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainCaptainViewController")
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
            if MOLHLanguage.isRTL() {
                let slideMenuController = SlideMenuController(mainViewController: mainViewController, rightMenuViewController: rightViewController)
                self.window?.rootViewController = slideMenuController
    
            }else {
                let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: rightViewController)
                self.window?.rootViewController = slideMenuController
                
                
            }
            self.window?.makeKeyAndVisible()
            SlideMenuOptions.contentViewScale = 1.0
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        
        print("Firebase registration token: \(fcmToken)")
        
        UserDefaults.standard.set(token, forKey: "FCMtoken")
        UserDefaults.standard.synchronize()
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        
        UserDefaults.standard.set(token, forKey: "_token")
        UserDefaults.standard.synchronize()
        print("Stored Token : \(token)")
        Messaging.messaging().apnsToken = deviceToken
        //print(Messaging.messaging().fcmToken!)
        
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        AudioServicesPlaySystemSound(1002)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        completionHandler(.newData)
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print("\(userInfo)")
        AudioServicesPlaySystemSound(1002)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        completionHandler()
    }
    
    
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    
    
}

