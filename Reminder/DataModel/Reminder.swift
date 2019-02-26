//
//  Reminder.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

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

extension Reminder: Displayable {}
