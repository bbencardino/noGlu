import Foundation

struct PhotosAPI: PhotosProtocol {

    private let network: Network
    private let endpoint = "https://maps.googleapis.com/maps/api/place/photo?"

    init(network: Network) {
        self.network = network
    }

    func getImageFrom(reference: String,
                      completion: @escaping (Result<Data, ServiceError>) -> Void) {

        let string = endpoint +
        "maxwidth=450" +
        "&photo_reference=\(reference)" +
        "&key=\(Auth.APIKey)"

        network.taskForGETRequest(endpoint: string) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
