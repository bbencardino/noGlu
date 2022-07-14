import UIKit

struct ResultCellViewModel {

    private let place: Place
    private let service: PhotosProtocol
    private let userDefaults: UserDefaultsProtocol

    init(place: Place,
         service: PhotosProtocol = PhotosAPI(network: Network()),
         userDefaults: UserDefaultsProtocol) {
        self.place = place
        self.service = service
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

    // MARK: - Photos

    private func fetchPhotoFromAPI(completion: @escaping (Data) -> Void) {

        guard let firstPhoto = place.photos.first else { fatalError("Fatal Error: There's no photo") }
        service.getImageFrom(reference: firstPhoto.photoReference) { result in
            switch result {
            case .success(let data):
                print(data)
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func image(completion: @escaping (UIImage?) -> Void) {
        fetchPhotoFromAPI { data in
            completion(UIImage(data: data))
        }
    }
}
