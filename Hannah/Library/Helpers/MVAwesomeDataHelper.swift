//
//  MVCoredataHelper.swift
//  Quests
//
//  Created by Evandro Harrison Hoffmann on 13/01/2017.
//  Copyright © 2017 Mindvalley. All rights reserved.
//

import AwesomeData

struct MVAwesomeDataHelper {
    
    static func start() {
        AwesomeData.setDatabase("Hannah")
    }
    
    static func saveContext() {
        AwesomeData.saveContext()
    }
    
}
