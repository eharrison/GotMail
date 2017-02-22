//
//  MessageHelper.swift
//  Hannah
//
//  Created by Evandro Harrison Hoffmann on 2/21/17.
//  Copyright © 2017 Evandro Harrison Hoffmann. All rights reserved.
//

import AwesomeData

struct MessageHelper {
    
    static let apiURL = "http://a142607d-c389-4c9d-bf10-105939f83a5d.pub.cloud.scaleway.com/"
    
    static func fetchMessages(loadView: UIView?, completion:@escaping (()->Void)) {
        
        loadView?.startLoadingAnimation()
        
        completion()
        
        _ = AwesomeRequester.performRequest("\(apiURL)grats") { (data) in
            loadView?.stopLoadingAnimation()
            if let jsonObjects = AwesomeParser.jsonObject(data) as? [[String: AnyObject]] {
                _ = Message.processObjects(jsonObjects)
                Message.save()
            }
            completion()
        }
    }
    
}

extension Message {
    
    static var todaysMessage: Message? {
        let today = Date().toString(format: "yyyy-MM-dd")
        return getObject(predicate: NSPredicate(format: "notificationDate CONTAINS[cd] %@", today)) as? Message
    }
    
    static func pastMessages() -> [Message] {
        var pastMessages = [Message]()
        
        let messages = Message.messages()
        for message in messages {
            if let todayMessage = todaysMessage, Int(todayMessage.id ?? "0")! >= Int(message.id ?? "0")! {
                pastMessages.append(message)
            }
        }
        
        return pastMessages
    }
    
    static func messages() -> [Message] {
        return Message.list(sortWith: "id", ascending: true) as! [Message]
    }
    
    static func processObjects(_ jsonObjects: [[String: AnyObject]]) -> [Message] {
        var messages = [Message]()
        
        for jsonObject in jsonObjects {
            if let message = Message.processObject(withJsonObject: jsonObject) {
                messages.append(message)
            }
        }
        
        Message.setNotfificationDates()
        
        return messages
    }
    
    static func processObject(withJsonObject jsonObject: [String: AnyObject]) -> Message? {
        let id = parseString(jsonObject, key: "id")
        guard id.characters.count > 0 else {
            return nil
        }
        
        if let message = Message.getObject(predicate: NSPredicate(format: "id == %@", id), createIfNil: true) as? Message {
            message.id = id
            message.author = parseString(jsonObject, key: "author")
            message.message = parseString(jsonObject, key: "msg")
            message.date = parseString(jsonObject, key: "time_stamp")
            message.ip = parseString(jsonObject, key: "ip")
        
            return message
        }
        
        return nil
    }
    
    static func setNotfificationDates() {
        let messages = Message.messages()
        
        var day = 0
        for message in messages {
            let interval = Double(24*60*60*day)
            message.notificationDate = startDate.addingTimeInterval(interval).toString(format: "yyyy-MM-dd HH:mm")
            
            day += 1
        }
    }
    
}
