//
//  NSDate+Quests.swift
//  Quests
//
//  Created by Evandro Harrison Hoffmann on 2/20/17.
//  Copyright © 2017 Mindvalley. All rights reserved.
//

import Foundation

extension NSDate {
    
    static func toString(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let date = Date(timeIntervalSinceReferenceDate: self.timeIntervalSinceReferenceDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
}

extension Date {
    
    func withTime(_ time: String, format: String = "HH:mm") -> Date{
        let date = self.toString(format: "yyyy/MM/dd")
        return date.appending(" \(time)").toDate(format: "yyyy/MM/dd \(format)")
    }
    
    static var tomorrow: Date? {
        let today = Date()
        return Calendar.current.date(byAdding: .day, value: 1, to: today)
    }
    
}
