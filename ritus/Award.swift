//
//  Award.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/26/24.
//

import Foundation

struct Award: Codable{
    let imageURL: String
    let inspirationQuotes: String
    let awardNote: String
}

extension Award {
    private static let awardsKey = "Awards"
    
    static func save(awards: [Award]){
        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(awards)
        defaults.setValue(encodedData, forKey: awardsKey)
    }
    
    static func getAwards() -> [Award] {
        let defaults = UserDefaults.standard
        
        if let data = defaults.data(forKey: awardsKey){
            let decodedData = try! JSONDecoder().decode([Award].self, from: data)
            return decodedData
        }
        
        return []
    }
    
    func save() {
        var awards = Award.getAwards()
        awards.append(self)
        Award.save(awards: awards)
    }
}
