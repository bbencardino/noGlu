import Foundation

final class HomeViewModel {

    private let placesService: PlacesProtocol
    private let userDefaults: UserDefaultsProtocol
    private let database: Database

    private var places: [Place] = []
    private var place: Int?

    // Helper functions
    var reloadView: (() -> Void)?
    var presentAlert: ((String) -> Void)?
    var performNavigation: ((Int) -> Void)?
    var startAnimatingActivityView: ((Bool) -> Void)?
    var stopAnimatingActivityView: (() -> Void)?

    init(service: PlacesProtocol = PlacesAPI(network: Network()),
         userDefaults: UserDefaultsProtocol = UserDataDefaults(),
         database: Database = CoreDataManager()) {
        self.placesService = service
        self.userDefaults = userDefaults
        self.database = database
    }

    func searchForPlaces(location: String, completion: @escaping (Result<Void, ServiceError>) -> Void) {
        placesService.getPlacesFromAPI(location: location) { [weak self] result in

            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    self?.places = places
                    self?.reloadView?()
                    self?.presentAlertForEmptyPlaces()
                }
                completion(.success(()))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Data Source
    func numberOfRows() -> Int {
        return places.count
    }

    // MARK: - UserDefaults

    func saveLastSearch(_ location: String) {
        userDefaults.write(location, forKey: "lastLocation")
    }

    func getLastSearch() -> String? {
        userDefaults.readString(forKey: "lastLocation")
    }

    // MARK: - Cell View Model
    func makeResultCellViewModel(at index: Int) -> ResultCellViewModel {
        var viewModel = ResultCellViewModel(place: places[index],
                                            userDefaults: userDefaults,
                                            database: database)
        viewModel.presentAlert = presentAlert
        return viewModel
    }

    // MARK: - Place Details
    func makePlaceDetailsViewModel(at index: Int) -> PlaceViewModel {
        return PlaceViewModel(place: places[index],
                              userDefaults: userDefaults,
                              database: database)
    }

    func presentPlace(at index: Int) {
        performNavigation?(index)
    }

    func presentAlertForEmptyPlaces() {
        if places.isEmpty {
            presentAlert?("There're no gluten free places for this location 😔")
        }
    }
}
