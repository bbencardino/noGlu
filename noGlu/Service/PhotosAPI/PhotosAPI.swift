import Foundation

struct PhotosAPI: PhotosProtocol {

    private let network: Network
    private let key = "AIzaSyC7XWt_9ElNUgyuozZu7XOLH5URT5cSCzY"
    private let baseStering = "https://maps.googleapis.com/maps/api/place/photo?"

    init(network: Network) {
        self.network = network
    }

    func getImageFrom(reference: String,
                      completion: @escaping (Result<Data, ServiceError>) -> Void) {

        let string = baseStering +
        "maxwidth=150" +
        "&photo_reference=\(reference)" +
        "&key=\(key)"

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
