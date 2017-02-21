//
//  StringExtensions.swift
//  Quests
//
//  Created by Evandro Harrison Hoffmann on 1/26/17.
//  Copyright © 2017 Mindvalley. All rights reserved.
//

import UIKit

extension String {
    
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    public func toDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? Date()
    }
    
}
