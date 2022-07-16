import Foundation

protocol Database {

    var placesMO: [PlaceMO]? { get }
    func createPlace(blob: Data, reference: String, name: String, favorite: Bool)
    func fetchImage(with reference: String) -> Data?
    func fetchPlace(with reference: String) -> PlaceMO?
    func save()
}
