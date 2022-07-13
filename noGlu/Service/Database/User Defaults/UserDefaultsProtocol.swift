import Foundation

protocol UserDefaultsProtocol {
    func write<T>(_ value: T, forKey key: String)
    func readBool(forKey key: String) -> Bool
}
