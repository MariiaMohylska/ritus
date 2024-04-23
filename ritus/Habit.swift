//
//  Tracker.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/17/24.
//

import UIKit

enum Weekday: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
}

class Habit : Codable {
    let id: String
    let name: String
    let description: String
    let frequency: [Frequency]
    var toDoDates: [Date: Bool] = [: ]
    var progress: Double {
        let count = countCompetedDays()
        return count / Double(toDoDates.count)
    }
    
    enum CodingKeys: String, CodingKey{
        case id, name, description, frequency, toDoDates
    }
    
    init(name: String, description: String, frequency: [Frequency], toDoDates: [Date: Bool]?) {
        self.id = UUID().uuidString
        self.name = name
        self.description = description
        self.frequency = frequency
        self.toDoDates = toDoDates ?? [: ];
        initDates()
    }
    
    func initDates(){
        let currentDate = Date()

        // Get the current calendar
        let calendar = Calendar.current

        // Get the current month and year components
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)

        // Get the start date of the current month
        guard let startDate = calendar.date(from: DateComponents(year: currentYear, month: currentMonth, day: 1)) else {
            fatalError("Failed to get the start date of the current month")
        }

        // Get the range of days in the current month
        guard let range = calendar.range(of: .day, in: .month, for: startDate) else {
            fatalError("Failed to get the range of days in the current month")
        }

        // Iterate through all the days of the current month
        var mondays: [Date] = []
        for day in 1...range.upperBound {
            // Construct the date for the current day
            guard let date = calendar.date(from: DateComponents(year: currentYear, month: currentMonth, day: day)) else {
                fatalError("Failed to construct the date for day \(day)")
            }
            
            guard let weekday = Frequency(rawValue:  calendar.component(.weekday, from: date)) else { return }
            // Check if the current day is a Monday (weekday number 2)
            if self.frequency.contains(weekday) {
                mondays.append(date)
            }
        }
        
        for day in mondays {
            self.toDoDates[day] = false
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        frequency  = try container.decode([Frequency].self, forKey: .frequency)
        
        let dateDict = try container.decode([String: Bool].self, forKey: .toDoDates)
        toDoDates = [: ]
        for(key, value) in dateDict {
            if let date = Habit.dateFormatter.date(from: key) {
                toDoDates[date] = value
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(frequency, forKey: .frequency)
        
        var dateDict: [String: Bool] = [: ]
        for (date, value) in toDoDates {
            dateDict[Habit.dateFormatter.string(from: date)] = value
        }
        
        try container.encode(dateDict, forKey: .toDoDates)
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private func countCompetedDays() -> Double {
        var numberOfCompletedDay = 0.0
        self.toDoDates.values.forEach{day in
            if day {
                numberOfCompletedDay+=1
            }
        }

        return numberOfCompletedDay
    }
    
}

extension Habit {
    static var habitKey: String{
        return "HabitTrackers"
    }
    
    static func save(_ habits: [Habit]){
        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(habits)
        defaults.set(encodedData, forKey: habitKey)
    }
    
    static func getHabits() -> [Habit] {
        let defaults = UserDefaults.standard
        
        if let data = defaults.data(forKey: habitKey) {
            let decodedHabit = try! JSONDecoder().decode([Habit].self, from: data)
            return decodedHabit
        } else {
            return []
        }
    }
    
    func save() {
        var habits = Habit.getHabits()
        if let index = habits.firstIndex(where: {habit in return habit.id == self.id}) {
            habits[index] = self
        } else {
            habits.append(self)
        }
        Habit.save(habits)
    }
    
    func delete() {
        var habits = Habit.getHabits()
        habits.removeAll(where: {habit in return self.id == habit.id})
        Habit.save(habits)
    }
}
