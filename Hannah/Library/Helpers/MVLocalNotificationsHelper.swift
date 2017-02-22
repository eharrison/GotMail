//
//  MVLocalNotifications.swift
//  Quests
//
//  Created by Evandro Harrison Hoffmann on 2/20/17.
//  Copyright © 2017 Mindvalley. All rights reserved.
//

import UIKit

struct MVLocalNotificationsHelper {
    
    static let timeIntervalWindow = 24*6 //every 10 minutes
    
    static func setupNotifications(){
        cancelAllNotifications()
        
        let messages = Message.messages()
        for message in messages {
            if let text = message.message, let id = message.id, let notificationDate = message.notificationDate?.toDate(format: "yyyy-MM-dd HH:mm") {
                scheduleNotification(NotificationItem(message: text, actionName: "Read it", date: notificationDate, objectType: "message", objectId: id, badgeNumber: 1, soundName: UILocalNotificationDefaultSoundName))
            }
        }
    }
    
    // MARK: - Configuration
    
    static func enableLocalNotifications(withApplication application: UIApplication){
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
    }
    
    static var isLocalNotificationEnabled: Bool {
        if let settings = UIApplication.shared.currentUserNotificationSettings{
            if settings.types.contains(.alert){
                return true
            }
        }
        return false
    }
    
    static func scheduleNotification(_ notificationItem: NotificationItem){
        //only proceed if date is in the future
        if notificationItem.date < Date() {
            return
        }
        
        let notification = UILocalNotification()
        notification.alertBody = "\(notificationItem.message)"
        notification.alertAction = notificationItem.actionName
        notification.fireDate = notificationItem.date
        notification.applicationIconBadgeNumber = notificationItem.badgeNumber
        notification.soundName = notificationItem.soundName
        notification.userInfo = ["message": notificationItem.message,
                                 "actionName": notificationItem.actionName,
                                 "objectType": notificationItem.objectType,
                                 "objectId": notificationItem.objectId]
        
        print("registering notification for the date: \(notification.fireDate!) with the information: \(notification.userInfo!)")
        
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    static func cancelAllNotifications(){
        UIApplication.shared.cancelAllLocalNotifications()
    }
    
    // MARK: - Popups
    
    static func showRemindOptions(withViewController viewController: UIViewController, callback:(()->Void)? = nil){
        let alertController = UIAlertController(title: nil, message: NSLocalizedString("When do you want me to remind you?", comment: ""), preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("In 15 Minutes", comment: ""), style: .default, handler: { (action) in
            callback?()
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("In 1 Hour", comment: ""), style: .default, handler: { (action) in
            callback?()
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { (action) in
            callback?()
        }))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    
    func showRemindOptions(callback:(()->Void)? = nil){
        MVLocalNotificationsHelper.showRemindOptions(withViewController: self, callback: callback)
    }
    
}

struct NotificationItem {
    var message: String
    var actionName: String
    var date: Date
    var objectType: String
    var objectId: String
    var badgeNumber = 1
    var soundName = UILocalNotificationDefaultSoundName
}

enum NotificationType: String {
    case dayReminder = "kNotificationDayReminder"
    case challenge = "kNotificationChallenge"
}
