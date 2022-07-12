import Foundation

final class HomeViewModel {

    private let placesService: PlacesProtocol
    var places: [Place] = []
    var reloadView: (() -> Void)?
    var performNavigation: ((Int) -> Void)?
    var place: Int?

    init(service: PlacesProtocol = PlacesAPI(network: Network())) {
        self.placesService = service
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
        return ResultCellViewModel(place: places[index])
    }

    // MARK: - Place Details
    func makePlaceDetailsViewModel(at index: Int) -> PlaceViewModel {
        return PlaceViewModel(place: places[index])
    }

    func presentPlace(at index: Int) {
        performNavigation?(index)
    }

    // try to make only one func - using generics
}
