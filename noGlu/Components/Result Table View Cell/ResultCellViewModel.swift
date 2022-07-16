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
    var isFavoritePlace: Bool { database.isFavorite(place.id) }
    var presentAlert: ((String) -> Void)?

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
        database.setIsFavorite(favorite, id: place.id)
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
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    database.createPlace(place, image: data)
                    completion(data)
                case .failure(let error):
                    if let presentAlert = presentAlert {
                        presentAlert(error.localizedDescription)
                    }
                }
            }
        }
    }
}
