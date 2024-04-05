//
//  appdelegate.swift
//  Login
//
//  Created by user1 on 21/02/24.
//

import UIKit
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Other methods...

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        // Other configurations...

        return true
    }

    // Other methods...

    // Add this method for Firebase Messaging
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Handle the notification...
        completionHandler(UIBackgroundFetchResult.newData)
    }
}
