import Foundation

struct ResultCellViewModel {
    private let place: Place
    private let userDefaults: UserDefaultsProtocol

    init(place: Place, userDefaults: UserDefaultsProtocol) {
        self.place = place
        self.userDefaults = userDefaults
    }

    var rating: String { String(place.rating) }
    var placeName: String { place.name }
    var priceRange: String { priceInCurrency(currency: "£") }
    var isFavoritePlace: Bool { saveFavoritePlace() }

    func priceInCurrency(currency: String) -> String {
        if let times = place.priceLevel {
            return String(repeating: currency, count: times)
        }
        return ""
    }

    // MARK: - Favourite place

    func markFavoritePlace(_ favorite: Bool) {
        userDefaults.write(favorite, forKey: placeName)
    }

    private func saveFavoritePlace() -> Bool {
        userDefaults.readBool(forKey: placeName)
    }
}
