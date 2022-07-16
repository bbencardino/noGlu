import Foundation

protocol PlacesProtocol {
    func getPlacesFromAPI(location: String,
                          completion: @escaping (Result<[Place], ServiceError>) -> Void)
}
