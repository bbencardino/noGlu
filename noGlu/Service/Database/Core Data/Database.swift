import Foundation

protocol Database {

    var favoritePlaces: [PlaceMO] { get }
    func createPlace(_ place: Place, image: Data)
    func fetchImage(with reference: String) -> Data?
    func fetchPlace(with id: String) -> PlaceMO?
    func setIsFavorite(_ value: Bool, id: String)
    func isFavorite(_ id: String) -> Bool
}
