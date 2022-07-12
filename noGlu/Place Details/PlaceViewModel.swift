import Foundation

final class PlaceViewModel {
    private let place: Place
    var placeName: String { place.name }
    var placeAddress: String { place.address }

    init(place: Place) {
        self.place = place
    }
}
