import Foundation
@testable import noGlu

final class MockPlaces: PlacesProtocol {
    func getPlacesFromAPI(location: String, completion: @escaping (Result<[Place], ServiceError>) -> Void) {

        let json = PlacesJSON.placesJSON
        let places = parsePlaces(data: Data(json.utf8))
        completion(.success(places))
    }

    func parsePlaces(data: Data) -> [Place] {
        // swiftlint: disable force_try
        return try! JSONDecoder().decode(Response.self, from: data).places
    }
}
