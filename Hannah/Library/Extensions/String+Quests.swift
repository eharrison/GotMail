//
//  String+Quests.swift
//  Quests
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 28/01/17.
//  Copyright © 2017 Mindvalley. All rights reserved.
//

import UIKit
import Foundation

extension String {
    func heightForCollectionCell(for width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil)
        return actualSize.height+2
    }
    
    var date: Date? {
        return date()
    }
    
    func date(withFormat format: String? = nil) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
    
    func nsDate(withFormat format: String? = nil) -> NSDate? {
        if let date = date(withFormat: format) {
            return NSDate(timeIntervalSince1970: date.timeIntervalSince1970)
        }
        return nil
    }
}
