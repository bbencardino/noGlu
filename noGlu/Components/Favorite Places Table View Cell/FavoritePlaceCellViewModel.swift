import UIKit

final class FavoritePlaceCellViewModel {

    var favoritePlace: PlaceMO

    var placeName: String { favoritePlace.name ?? "Restaurant name" }
    var rating: String { String(favoritePlace.rating) }
    var priceRange: String { priceInCurrency(currency: "£") }

    init(favoritePlace: PlaceMO) {
        self.favoritePlace = favoritePlace
    }

    private func priceInCurrency(currency: String) -> String {
        let times = Int(favoritePlace.priceLevel)
        if times > 0 {
            return String(repeating: currency, count: times)
        }
        return ""
    }

    func image() -> UIImage? {
        guard let data = favoritePlace.blob,
              let image = UIImage(data: data) else {
            return UIImage(named: "placeholder")
        }
        return image
    }
}
