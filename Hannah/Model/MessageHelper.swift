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
    
    static func readMessages() -> [Message] {
        return Message.list(sortDescriptor: NSSortDescriptor(key:"id", ascending:false), predicate: NSPredicate(format: "read == %d", NSNumber(value: true))) as! [Message]
    }
    
    static func unreadMessages() -> [Message] {
        return Message.list(sortDescriptor: NSSortDescriptor(key:"id", ascending:false), predicate: NSPredicate(format: "read == %d", NSNumber(value: false))) as! [Message]
    }
    
    static func messages() -> [Message] {
        return Message.list(sortWith: "id", ascending: false) as! [Message]
    }
    
    static func processObjects(_ jsonObjects: [[String: AnyObject]]) -> [Message] {
        var messages = [Message]()
        
        for jsonObject in jsonObjects {
            if let message = Message.processObject(withJsonObject: jsonObject) {
                messages.append(message)
            }
        }
        
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
    
}
