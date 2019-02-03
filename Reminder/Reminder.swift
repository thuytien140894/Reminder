//
//  Reminder.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import Foundation

struct Reminder: Equatable {
    
    var content: String
    var deadline: String
    var isCompleted: Bool
    var identifier: String
    
    var jsonObject: [String: Any] {
        return [
            "content": content,
            "deadline": deadline,
            "isCompleted": isCompleted,
            "id": identifier
        ]
    }
}

extension Reminder {
    
    init?(jsonObject: [String: Any]) {
        
        guard
            let content = jsonObject["content"] as? String,
            let deadline = jsonObject["deadline"] as? String,
            let isCompleted = jsonObject["isCompleted"] as? Bool,
            let identifier = jsonObject["id"] as? String else { return nil }
        
        self.init(
            content: content,
            deadline: deadline,
            isCompleted: isCompleted,
            identifier: identifier
        )
    }
    
    init(content: String, deadline: String, isCompleted: Bool) {
        
        self.content = content
        self.deadline = deadline
        self.isCompleted = isCompleted
        self.identifier = ""
    }
}

struct ReminderList: CollectionViewCellDisplayModel, Equatable {
    
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

struct ReminderUser {
    
    var name: String
}
