//
//  ReminderList.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 2/24/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

protocol Displayable {}

struct ReminderList: Equatable {
    
    var title: String
    var taskCount: Int
    var doneTaskCount: Int
    
    var jsonObject: [String: Any] {
        return [
            "title": title,
            "taskCount": taskCount,
            "doneTaskCount": doneTaskCount
        ]
    }
    
    mutating func reset() {
        
        taskCount = 0
        doneTaskCount = 0
    }
}

extension ReminderList {
    
    init?(jsonObject: [String: Any]) {
        
        guard
            let title = jsonObject["title"] as? String,
            let taskCount = jsonObject["taskCount"] as? Int,
            let doneTaskCount = jsonObject["doneTaskCount"] as? Int else { return nil }
        
        self.init(title: title, taskCount: taskCount, doneTaskCount: doneTaskCount)
    }
    
    init(title: String) {
        
        self.init(title: title, taskCount: 0, doneTaskCount: 0)
    }
}

extension ReminderList: CollectionViewCellDisplayable {}
