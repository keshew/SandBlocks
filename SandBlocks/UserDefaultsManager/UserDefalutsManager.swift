import Foundation

enum Keys: String {
    case numberOfLevel = "numberOfLevel"
    case countOfMoney = "countOfMoney"
}

class UserDefaultsManager {
    static let defaults = UserDefaults.standard
    
    func firstLaunch() {
        if UserDefaultsManager.defaults.string(forKey: Keys.numberOfLevel.rawValue) == nil {
            UserDefaultsManager.defaults.set(1, forKey: Keys.numberOfLevel.rawValue)
            UserDefaultsManager.defaults.set(1000, forKey: Keys.countOfMoney.rawValue)
        }
    }
    
    func completeLevel() {
        let level = UserDefaultsManager.defaults.object(forKey: Keys.numberOfLevel.rawValue) as? Int ?? 0
        let money = UserDefaultsManager.defaults.object(forKey: Keys.countOfMoney.rawValue) as? Int ?? 0
        if level < 13 {
            UserDefaultsManager.defaults.set(level + 1, forKey: Keys.numberOfLevel.rawValue)
            UserDefaultsManager.defaults.set(money + 30, forKey: Keys.countOfMoney.rawValue)
        }
    }
}
