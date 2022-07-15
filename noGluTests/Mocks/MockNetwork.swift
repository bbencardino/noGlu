import Foundation
@testable import noGlu

final class MockNetwork: NetworkProtocol {

    func taskForGETRequest(endpoint: String, completion: @escaping (Result<Data, ServiceError>) -> Void) {

        //let fakeJson = PlacesJSON.placesJSON
        let min =
"""
{
  "results": []
}
"""
        completion(.success(Data(min.utf8)))
    }
}
