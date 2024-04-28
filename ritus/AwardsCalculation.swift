//
//  AwardsCalculation.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/26/24.
//

import Foundation
import UIKit

class AwardsCalculation{
    static func checkAwards(imagesForAward: [Image], inspirationsForAward: [String]) -> String {
        let habits = Habit.getHabits()
        
        var fiftyPercentHabits: [Habit] = []
        var seventyFivePercentHabits: [Habit] = []
        var awards: [Award] = []
        
        let addNewAward: (_ name: String) -> Void = {name in
            awards.append(Award(imageURL: imagesForAward.randomElement()?.urls.full ?? "", inspirationQuotes: inspirationsForAward.randomElement() ?? "", awardNote: name))
        }
        
        for habit in habits {
            if habit.createdDate.compareMonth() {
                if habit.awardList.isEmpty{
                    if checkCompletionWithinWeek(toDoDates: habit.toDoDates, amontOfWeek: 1){
                        habit.assignAward(.oneWeekStrike)
                        addNewAward("\(AwardsType.oneWeekStrike.rawValue) \(habit.name)")
                    }
                }
                
                if habit.hasAward(.oneWeekStrike) && !habit.hasAward(.twoWeeksStrike)                {
                    if checkCompletionWithinWeek(toDoDates: habit.toDoDates, amontOfWeek: 2) {
                        habit.assignAward(.twoWeeksStrike)
                        addNewAward("\(AwardsType.twoWeeksStrike.rawValue) \(habit.name)")
                    }
                }
                
            } else {
                fiftyPercentHabits.append(habit)
                seventyFivePercentHabits.append(habit)
                
                if habit.progress == 100.0 {
                    if  !habit.hasAward(.oneMonthStrike){
                        habit.assignAward(.oneMonthStrike)
                        addNewAward("\(AwardsType.oneMonthStrike.rawValue) \(habit.name)")
                        
                    } else if habit.hasAward(.oneMonthStrike) && !habit.hasAward(.twoMonthStrike){
                        habit.assignAward(.twoMonthStrike)
                        addNewAward("\(AwardsType.twoMonthStrike.rawValue) \(habit.name)")
                    } else if habit.hasAward(.twoMonthStrike) && !habit.hasAward(.threeMonthStrike){
                        habit.assignAward(.threeMonthStrike)
                        addNewAward("\(AwardsType.threeMonthStrike.rawValue) \(habit.name)")
                    } else if habit.hasAward(.threeMonthStrike) && !habit.hasAward(.fourMonthStrike){
                        habit.assignAward(.fourMonthStrike)
                    } else if habit.hasAward(.fourMonthStrike) && !habit.hasAward(.fiveMonthStrike){
                        habit.assignAward(.fiveMonthStrike)
                    } else if habit.hasAward(.fiveMonthStrike) && !habit.hasAward(.sixMonthStrike){
                        habit.assignAward(.sixMonthStrike)
                        addNewAward("\(AwardsType.sixMonthStrike.rawValue) \(habit.name)")
                    } else if habit.hasAward(.sixMonthStrike) && !habit.hasAward(.sevenMonthStrike){
                        habit.assignAward(.sevenMonthStrike)
                    } else if habit.hasAward(.sevenMonthStrike) && !habit.hasAward(.eightMonthStrike){
                        habit.assignAward(.eightMonthStrike)
                    } else if habit.hasAward(.eightMonthStrike) && !habit.hasAward(.nineMonthStrike){
                        habit.assignAward(.nineMonthStrike)
                    } else if habit.hasAward(.nineMonthStrike) && !habit.hasAward(.tenMonthStrike){
                        habit.assignAward(.tenMonthStrike)
                    } else if habit.hasAward(.tenMonthStrike) && !habit.hasAward(.elevenMonthStrike){
                        habit.assignAward(.elevenMonthStrike)
                    } else if habit.hasAward(.elevenMonthStrike) && !habit.hasAward(.oneYearStrike){
                        habit.assignAward(.oneYearStrike)
                        addNewAward("\(AwardsType.oneYearStrike.rawValue) \(habit.name)")
                    }
                    
                } else if habit.progress >= 90  && !habit.hasAward(.nintyPercentOfMonth){
                    habit.assignAward(.nintyPercentOfMonth)
                    addNewAward("\(AwardsType.nintyPercentOfMonth.rawValue) \(habit.name)")
                } else if habit.progress >= 75 {
                    if !habit.hasAward(.seventyFivePersentOfMonth){
                        habit.assignAward(.seventyFivePersentOfMonth)
                        addNewAward("\(AwardsType.seventyFivePersentOfMonth.rawValue) \(habit.name)")
                    } else {
                        seventyFivePercentHabits.removeLast()
                    }
                } else if habit.progress >= 50 {
                    if !habit.hasAward(.fiveMonthStrike) {
                        seventyFivePercentHabits.removeLast()
                        habit.assignAward(.fiftyPercentOfMonth)
                        addNewAward("\(AwardsType.fiveMonthStrike.rawValue) \(habit.name)")
                    } else {
                        fiftyPercentHabits.removeLast()
                    }
                } else {
                    fiftyPercentHabits.removeLast()
                }
                
                habit.initDates()
            }
            
            habit.save()
        }
        
        if fiftyPercentHabits.count >= 5 {
            var names = ""
            for habit in fiftyPercentHabits {
                names = "\(names) '\(habit.name)'"
            }
            addNewAward("\(AwardsType.fiveHabitsMoreThanFifty.rawValue) \(names)")
        }
        
        if seventyFivePercentHabits.count >= 3 {
            var names = ""
            for habit in seventyFivePercentHabits {
                names = "\(names) '\(habit.name)'"
            }
            addNewAward("\(AwardsType.threeHabitsMoreThanSeventyFive.rawValue) \(names)")
        }
        
        var previosAwards = Award.getAwards()
        previosAwards.append(contentsOf: awards)
        Award.save(awards: previosAwards)
        
        var allAwardsName = ""
        
        for award in awards {
            allAwardsName = "\(allAwardsName) \n \(award.awardNote)"
        }
        
        return allAwardsName
    }
    
    private static func checkCompletionWithinWeek(toDoDates: [Date: Bool], amontOfWeek: Int) -> Bool {
            let currentDate = Date()
            
            let calendar = Calendar.current
            guard let oneWeekAgo = calendar.date(byAdding: .weekOfYear, value: -amontOfWeek, to: currentDate) else {
                return false
            }
            
            let entriesWithinLastWeek = toDoDates.filter { date, completed in
                date >= oneWeekAgo && date <= currentDate
            }
            
            return entriesWithinLastWeek.values.allSatisfy { $0 }
        }
}
