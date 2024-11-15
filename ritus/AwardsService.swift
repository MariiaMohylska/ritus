//
//  AwardsService.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/26/24.
//

import Foundation

class AwardsService {
    
    static func fetchImage(completion:(([Image]?) -> Void)? = nil) {
        let accesKey = "yDp7A4QHHED92B1UMQGRlcII1SKBCOQFox4D5yW8l6s"
        let url = URL(string: "https://api.unsplash.com/search/photos/?client_id=\(accesKey)&query=funny-pets&count=50")!
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard error == nil else {
                assertionFailure("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Incalid response")
                return
            }
            
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response code status code: \(httpResponse.statusCode)")
                return
            }
            
            let decoder = JSONDecoder()
            let response = try! decoder.decode(ResultImages.self, from: data)
            DispatchQueue.main.async {
                completion?(response.results)
            }
            
        }.resume()
    }
    
    static func fetchInspirationQuotes(completion: (([String]) -> Void)? = nil) {
        let url = URL(string: "https://type.fit/api/quotes")!
        let _: Void = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard error == nil else {
                assertionFailure("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid status code: \(httpResponse.statusCode)")
                return
            }
            
            let decoder = JSONDecoder()
            let response = try! decoder.decode([InspirationQuote].self, from: data)
            DispatchQueue.main.async {
                completion?(response.map{quote in return quote.text})
            }
        }.resume()
    }
}

struct ResultImages: Codable{
    let results: [Image]
}

struct Image: Codable {
    let urls: ImageLinks
}

struct ImageLinks: Codable {
    let full: String
}

struct InspirationQuote: Codable {
    let text: String
}
