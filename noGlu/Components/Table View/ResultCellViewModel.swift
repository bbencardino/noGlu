import UIKit

struct ResultCellViewModel {

    private let place: Place
    private let service: PhotosProtocol
    private let userDefaults: UserDefaultsProtocol
    private let database: Database

    init(place: Place,
         service: PhotosProtocol = PhotosAPI(network: Network()),
         userDefaults: UserDefaultsProtocol,
         database: Database) {

        self.place = place
        self.service = service
        self.userDefaults = userDefaults
        self.database = database
    }

    var rating: String { String(place.rating) }
    var placeName: String { place.name }
    var priceRange: String { priceInCurrency(currency: "£") }
    var isFavoritePlace: Bool { saveFavoritePlace() }

    private var photoReference: String {
        guard let firstPhoto = place.photos.first else { fatalError("Fatal Error: There's no photo") }
        return firstPhoto.photoReference
    }

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

    func image(completion: @escaping (UIImage?) -> Void) {

        if let data = database.fetchImage(with: photoReference) {
            completion(UIImage(data: data))
        } else {
            fetchPhotoFromAPI { data in
                completion(UIImage(data: data))
            }
        }
    }

    private func fetchPhotoFromAPI(completion: @escaping (Data) -> Void) {

        service.getImageFrom(reference: photoReference) { result in
            switch result {
            case .success(let data):
                print(data)
                database.createImage(blob: data,
                                     reference: photoReference)
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
