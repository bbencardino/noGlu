import Foundation

protocol NetworkProtocol {
    func taskForGETRequest(endpoint: String,
                           completion: @escaping(Result<Data, ServiceError>) -> Void)
}
