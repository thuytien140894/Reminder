//
//  Reminder.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import Foundation

struct Reminder {
    
    var content: String
    var deadline: String
    var isCompleted: Bool
    
    var jsonObject: [String: Any] {
        
        return [
            "content": content,
            "deadline": deadline,
            "isCompleted": isCompleted
        ]
    }
}

extension Reminder {
    
    init?(jsonObject: [String: Any]) {
        
        guard let content = jsonObject["content"] as? String,
            let deadline = jsonObject["deadline"] as? String,
            let isCompleted = jsonObject["isCompleted"] as? Bool else { return nil }
        
        self.init(
            content: content,
            deadline: deadline,
            isCompleted: isCompleted
        )
    }
}

struct ReminderList {
    
    var title: String
}

extension ReminderList {
    
    init?(jsonObject: [String: Any]) {
        
        guard let title = jsonObject["title"] as? String else { return nil }
        
        self.init(title: title)
    }
}

struct ReminderUser {
    
    var name: String
}

