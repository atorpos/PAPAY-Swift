//
//  PAPAY_SwiftApp.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 5/26/21.
//

import SwiftUI
import os
import Firebase
import FirebaseMessaging
import UserNotifications

@main
struct PAPAY_SwiftApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var viewRouter = ViewRouter()


    var body: some Scene {
        WindowGroup {

            if (UserDefaults.standard.string(forKey: "token") == nil) {
                LoginView(viewRouter: viewRouter)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                ContentView(viewRouter: viewRouter)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey =   "gcm.message_id"
    let appgroup:String = "group.com.paymentasia.papayswift"
    
    static var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        let standarddefault = UserDefaults.standard
        print ("standard = \(standarddefault.string(forKey: "token") ?? "")")
//        print("testing \(UserDefaults.standard.string(forKey: "token") as? String)")
        UserDefaults(suiteName: appgroup)!.set("\(UserDefaults.standard.string(forKey: "token") ?? "")", forKey: "token")
        UserDefaults(suiteName: appgroup)!.set("\(UserDefaults.standard.string(forKey: "qrcode") ?? "")", forKey: "qrcode")
        
//        if let syncdefaults = UserDefaults(suiteName: appgroup) {
//            syncdefaults.set(UserDefaults.standard.string(forKey:"token"), forKey: "token")
//            syncdefaults.synchronize()
//        }
        
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOption, completionHandler: {_, _ in}
        )
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping(UIBackgroundFetchResult)->Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID:\(messageID)")
        }
        
        completionHandler(UIBackgroundFetchResult.newData)

    }
    
    //No callback in simulator -- must use device to get valid push token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().isAutoInitEnabled = true
        print(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("entered background")
    }
    func application(_ application: UIApplication, performFetchWithCompletionHandler compleionHandler: @escaping(UIBackgroundFetchResult) -> Void) {
        let painfo = PapayInfo()
        let return_value: String = painfo.infopapay()
        guard return_value != "" else {
            compleionHandler(.failed)
            return
        }
        if return_value.isEmpty {
            compleionHandler(.noData)
        } else {
            compleionHandler(.newData)
        }
        
    }
    
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        let deviceToken:[String: String] = ["token":fcmToken ?? ""]
        let fcmtoken:String = fcmToken!
        let userDefaults = UserDefaults.standard
//        print("Device token:", fcmtoken)
        
        userDefaults.set(fcmtoken, forKey: "fcmtoken")
    }
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        
        completionHandler([[.banner, .badge, .sound]])
    }
}


