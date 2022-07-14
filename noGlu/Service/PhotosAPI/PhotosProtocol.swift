import Foundation

protocol PhotosProtocol {

    func getImageFrom(reference: String,
                      completion: @escaping (Result<Data, ServiceError>) -> Void)
}
