//
//  Extensions.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/26/24.
//

import Foundation

extension Date {
    func compareDateToCurrent() -> Bool {
        let currentDay = Date()
        
        let calendar = Calendar.current
        
        let components1 = calendar.dateComponents([.year, .month, .day], from: currentDay)
        let components2 = calendar.dateComponents([.year, .month, .day], from: self)
        
        if components1.year == components2.year && components1.month == components2.month && components1.day == components2.day {
            return true
        } else {
            return false
        }
    }
    
    func compareMonth () -> Bool {
        let currentDay = Date()
        
        let calendar = Calendar.current
        
        let components1 = calendar.dateComponents([.year, .month], from: currentDay)
        let components2 = calendar.dateComponents([.year, .month], from: self)
        
        if components1.year == components2.year && components1.month == components2.month {
            return true
        } else {
            return false
        }
    }
}
