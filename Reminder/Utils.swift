//
//  Utils.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 2/2/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

class Utils {
    
    static func isNotOutOfBounds(index: Int, arrayCount: Int) -> Bool {
        
        return (0..<arrayCount).contains(index)
    }
}
