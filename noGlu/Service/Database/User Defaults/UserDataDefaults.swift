import Foundation

final class UserDataDefaults: UserDefaultsProtocol {

    let userDefaults = UserDefaults.standard

    func write<T>(_ value: T, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    func readBool(forKey key: String) -> Bool {
        userDefaults.bool(forKey: key)
    }
}
