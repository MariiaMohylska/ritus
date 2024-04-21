//
//  Tracker.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/17/24.
//

import UIKit

class Habit : Codable {
    let id: String
    let name: String
    let description: String
    let frequency: [Frequency]
    var toDoDates: [Date: Bool]
    var progress: Double {
        return 0
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
        print("New habit was screated with this information: name -> \(name)   description -> \(description)   frequency -> \(frequency)")
    }
    
    func initDates(){
        if toDoDates.isEmpty && !frequency.isEmpty{}
        toDoDates = [: ]
        // Create map of days when is needed to do habit within 1 month
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
}
