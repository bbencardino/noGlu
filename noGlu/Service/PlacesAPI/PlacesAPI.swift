import Foundation

final class PlacesAPI: PlacesProtocol {

    private let apiKey = ""
    private let endpoint = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=glutenfreein"

    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func getPlacesFromAPI(location: String,
                          completion: @escaping (Result<[Place], ServiceError>) -> Void) {

        let json = PlacesJSON.placesJSON
        let places = parsePlaces(data: Data(json.utf8))
        completion(.success(places))
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
