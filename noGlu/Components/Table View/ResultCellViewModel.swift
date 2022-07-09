import Foundation

struct ResultCellViewModel {
    private let place: Place

    init(place: Place) {
        self.place = place
    }

    var rating: String { String(place.rating) }
    var placeName: String { place.name }
    var priceRange: String { priceInCurrency(currency: "£") }

    func priceInCurrency(currency: String) -> String {

        if let times = place.priceLevel {
            return String(repeating: currency, count: times)
        }

        return ""
    }
}
