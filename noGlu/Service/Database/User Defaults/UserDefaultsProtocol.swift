import Foundation

protocol UserDefaultsProtocol {
    func write<T>(_ value: T, forKey key: String)
    func readString(forKey key: String) -> String
}
