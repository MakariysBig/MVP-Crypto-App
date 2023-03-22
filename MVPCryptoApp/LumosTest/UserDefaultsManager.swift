import Foundation

enum UserDefaultsManager {
    static var userIsLogin: Bool {
        get { UserDefaults.standard.value(forKey: "userIsLogin") as? Bool ?? false }
        set { UserDefaults.standard.setValue(newValue, forKey: "userIsLogin") }
    }
}
