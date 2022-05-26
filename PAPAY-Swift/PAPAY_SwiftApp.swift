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
    
//    @StateObject var notificationCenter = NotificationCenter()
//    init () {
//        FirebaseApp.configure()
//    }
    @StateObject var viewRouter = ViewRouter()

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
//            HomeView(viewRouter:viewRouter)
            if (UserDefaults.standard.string(forKey: "token") == nil) {
                LoginView(viewRouter: viewRouter)
//                ContentView(viewRouter: viewRouter)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                ContentView(viewRouter: viewRouter)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    let gcmMessageIDKey =   "gcm.message_id"
    
    static var orientationLock = UIInterfaceOrientationMask.all
    
   
//    extension AppDelegate: MessagingDelegate{
//        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//            let deviceToken:[String:String] = ["token": fcmToken??,""]
//            print("Device token: ", deviceToken)
//        }
//
//    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
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
        print(userInfo)
        
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
}

//class NotificationCenter: NSObject, ObservableObject {
//    @Published var dumbData: UNNotificationResponse?
//
//    override init() {
//        super.init()
//        UNUserNotificationCenter.current().delegate = self
//    }
//}
//
//extension NotificationCenter: UNUserNotificationCenterDelegate  {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert, .sound, .badge])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        dumbData = response
//        completionHandler()
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) { }
//}
//
//class LocalNotification: ObservableObject {
//    init() {
//
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (allowed, error) in
//            //This callback does not trigger on main loop be careful
//            if allowed {
//                os_log(.debug, "Allowed")
//            } else {
//                os_log(.debug, "Error")
//            }
//        }
//    }
//
//    func setLocalNotification(title: String, subtitle: String, body: String, when: Double) {
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.subtitle = subtitle
//        content.body = body
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: when, repeats: false)
//        let request = UNNotificationRequest.init(identifier: "localNotificatoin", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//
//    }
//}


