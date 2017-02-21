//
//  Date+Formatting.swift
//  Quests
//
//  Created by Evandro Harrison Hoffmann on 1/26/17.
//  Copyright © 2017 Mindvalley. All rights reserved.
//

import Foundation

extension Date {
    public func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public func days(toDate date:Date) -> Int{
        // Replace the hour (time) of both dates with 00:00
        let date1 = Calendar.current.startOfDay(for: self)
        let date2 = Calendar.current.startOfDay(for: date)
        
        let components = Calendar.current.dateComponents([Calendar.Component.day], from: date1, to: date2)
        
        if let days = components.day {
            return days
        }
        return 0
    }
    
    public func hours(toDate date:Date) -> Int{
        let components = Calendar.current.dateComponents([Calendar.Component.hour], from: self, to: date)
        
        if let hours = components.hour {
            return hours
        }
        return 0
    }
    
    public func minutes(toDate date:Date) -> Int{
        let components = Calendar.current.dateComponents([Calendar.Component.minute], from: self, to: date)
        
        if let minutes = components.minute {
            return minutes
        }
        return 0
    }
    
    public var lapseString: String {
        let daysAgo = self.days(toDate: Date())
        let hoursAgo = self.hours(toDate: Date())
        let minutesAgo = self.minutes(toDate: Date())
        
        if daysAgo > 1 {
            return self.toString(format: "MMM dd").appendingFormat(" %@ %@", "at".localized, self.toString(format: "h:mm a").lowercased())
        }else if daysAgo == 1 {
            return "yesterday".localized
        }else if hoursAgo > 1 {
            return String(format: "%d %@", hoursAgo, "hours_ago".localized)
        }else if hoursAgo == 1 {
            return "1_hour_ago".localized
        }else if minutesAgo > 1 {
            return String(format: "%d %@", minutesAgo, "minutes_ago".localized)
        }else {
            return "now".localized
        }
    }
}
