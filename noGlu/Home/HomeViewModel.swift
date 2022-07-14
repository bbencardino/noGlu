import Foundation

final class HomeViewModel {

    private let placesService: PlacesProtocol
    private let userDefaults: UserDefaultsProtocol
    private let database: Database

    var places: [Place] = []
    var reloadView: (() -> Void)?
    var performNavigation: ((Int) -> Void)?
    var place: Int?

    init(service: PlacesProtocol = PlacesAPI(network: Network()),
         userDefaults: UserDefaultsProtocol = UserDataDefaults(),
         database: Database = CoreDataManager()) {
        self.placesService = service
        self.userDefaults = userDefaults
        self.database = database
    }

    func searchForPlaces(location: String, completion: @escaping (Result<Void, ServiceError>) -> Void) {
        placesService.getPlacesFromAPI(location: location) { [self] result in
            switch result {
            case .success(let places):
                self.places = places
                completion(.success(()))
                print(places.count)
                self.reloadView?()
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    // MARK: - Data Source
    func numberOfRows() -> Int {
        return places.count
    }

    // MARK: - Cell View Model
    func makeResultCellViewModel(at index: Int) -> ResultCellViewModel {
        return ResultCellViewModel(place: places[index],
                                   userDefaults: userDefaults,
                                   database: database)
    }

    // MARK: - Place Details
    func makePlaceDetailsViewModel(at index: Int) -> PlaceViewModel {
        return PlaceViewModel(place: places[index],
                              userDefaults: userDefaults)
    }

    func presentPlace(at index: Int) {
        performNavigation?(index)
    }
}
