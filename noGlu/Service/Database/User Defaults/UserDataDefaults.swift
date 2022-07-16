import Foundation

final class UserDataDefaults: UserDefaultsProtocol {

    let userDefaults = UserDefaults.standard

    func write<T>(_ value: T, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    func readString(forKey key: String) -> String {
        userDefaults.string(forKey: key) ?? ""
    }
}
