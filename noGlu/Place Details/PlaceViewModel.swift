import Foundation
import UIKit

final class PlaceViewModel {

    private let place: Place
    private let userDefaults: UserDefaultsProtocol
    private let database: Database
    var placeName: String { place.name }
    var placeAddress: String { place.address }
    var isFavoritePlace: Bool { database.isFavorite(place.id) }

    private var photoReference: String {
        guard let firstPhoto = place.photos.first else {
            fatalError("Fatal Error: There's no photo")
        }
        return firstPhoto.photoReference
    }

    init(place: Place, userDefaults: UserDefaultsProtocol, database: Database) {
        self.place = place
        self.userDefaults = userDefaults
        self.database = database
    }

    // MARK: - User defaults
    func markFavoritePlace(_ favorite: Bool) {
        database.setIsFavorite(favorite, id: place.id)
    }

    // MARK: - Core data
    func image() -> UIImage? {
        if let data = database.fetchImage(with: photoReference) {
            return UIImage(data: data)
        } else {
            return UIImage(named: "placeholder")
        }
    }
}
