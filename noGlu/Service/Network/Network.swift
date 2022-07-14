import Foundation

final class Network: NetworkProtocol {

    private let session = URLSession.shared

    func taskForGETRequest(endpoint: String,
                           completion: @escaping (Result<Data, ServiceError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.wrongURL))
            return
        }
        let dataTask = session.dataTask(with: url) { data, response, _ in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completion(.failure(.noData))
                return
            }

            completion(.success(data))
        }
        dataTask.resume()
    }
}
