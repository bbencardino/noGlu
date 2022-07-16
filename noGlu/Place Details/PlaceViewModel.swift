import Foundation
import UIKit

final class PlaceViewModel {

    private let place: Place
    private let userDefaults: UserDefaultsProtocol
    private let database: Database
    var placeName: String { place.name }
    var placeAddress: String { place.address }
    var isFavoritePlace: Bool { saveFavoritePlace() }

    init(place: Place, userDefaults: UserDefaultsProtocol, database: Database) {
        self.place = place
        self.userDefaults = userDefaults
        self.database = database
    }

    // MARK: - User defaults
    func markFavoritePlace(_ favorite: Bool) {
        userDefaults.write(favorite, forKey: placeName)
    }

    private func saveFavoritePlace() -> Bool {
        userDefaults.readBool(forKey: placeName)
    }

    // MARK: - Core data
    func image() -> UIImage? {

        guard let photoReference = place.photos.first?.photoReference else {
            fatalError("Fatal Error: There're no photo")
        }
        if let data = database.fetchImage(with: photoReference) {
            
            return UIImage(data: data)
        } else {
            return UIImage(named: "placeholder")
        }
    }
}
