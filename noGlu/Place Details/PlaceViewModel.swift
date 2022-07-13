import Foundation

final class PlaceViewModel {

    private let place: Place
    private let userDefaults: UserDefaultsProtocol
    var placeName: String { place.name }
    var placeAddress: String { place.address }
    var isFavoritePlace: Bool { saveFavoritePlace() }

    init(place: Place, userDefaults: UserDefaultsProtocol) {
        self.place = place
        self.userDefaults = userDefaults
    }

    func markFavoritePlace(_ favorite: Bool) {
        userDefaults.write(favorite, forKey: placeName)
    }

    private func saveFavoritePlace() -> Bool {
        userDefaults.readBool(forKey: placeName)
    }
}
