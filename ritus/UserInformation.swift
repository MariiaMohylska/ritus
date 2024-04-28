import Foundation

class UserInformation: Codable {
    static var userInfoKey: String{
        return "UserInfo"
    }
    
    var lastCheckingDate: Date
    
    init(lastCheckingDate: Date = Date(timeIntervalSince1970: 1711513169)) {
        self.lastCheckingDate = lastCheckingDate
    }
    
    static func saveInformation(user: UserInformation) {
        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(user)
        defaults.setValue(encodedData, forKey: userInfoKey)
    }
    
    static func getInformation() -> UserInformation? {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: userInfoKey) {
            do {
                let decodedData = try JSONDecoder().decode(UserInformation.self, from: data)
                return decodedData
//                return Us/*erInformation()*/
            } catch {
                print("Error decoding user information: \(error)")
            }
        }
        return nil
    }
}
