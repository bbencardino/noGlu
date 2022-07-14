import Foundation

protocol Database {
    func createImage(blob: Data, reference: String)
    func fetchImage(with reference: String) -> Data?
    var images: [Image]? { get set }
}
