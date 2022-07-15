import Foundation

final class PlacesAPI: PlacesProtocol {

    private let apiKey = "API_KEY"
    private let endpoint = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=glutenfreein"

    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func getPlacesFromAPI(location: String,
                          completion: @escaping (Result<[Place], ServiceError>) -> Void) {

        let stringBase = endpoint + location + "&key=\(apiKey)"
        network.taskForGETRequest(endpoint: stringBase) { [weak self] result in
            switch result {
            case .success(let data):
                guard let places = self?.parsePlaces(data: data) else {
                    fatalError("Fatal Error: Place failed to parse.")
                }
                completion(.success(places))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func parsePlaces(data: Data) -> [Place] {
        let decoder = JSONDecoder()
        do {
            let places = try decoder.decode(Response.self, from: data)
            return places.places
        } catch {
            fatalError("Error: not able to parse data to Place. \(error.localizedDescription)")
        }
    }
}
