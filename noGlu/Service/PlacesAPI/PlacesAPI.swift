import Foundation

final class PlacesAPI: PlacesProtocol {

    private let endpoint = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=glutenfreein"

    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func getPlacesFromAPI(location: String,
                          completion: @escaping (Result<[Place], ServiceError>) -> Void) {
        let formattedLocation = location.replacingOccurrences(of: " ", with: "")

        let stringBase = endpoint + formattedLocation + "&key=\(Auth.APIKey)"
        network.taskForGETRequest(endpoint: stringBase) { [weak self] result in
            switch result {
            case .success(let data):
                guard let places = self?.parsePlaces(data: data) else {
                    completion(.failure(.badFormattedString))
                    return
                }
                completion(.success(places))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

     private func parsePlaces(data: Data) -> [Place]? {
        let places = try? JSONDecoder().decode(Response.self, from: data)
        return places?.places
    }
}
