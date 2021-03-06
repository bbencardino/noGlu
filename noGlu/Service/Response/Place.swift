import Foundation

struct Response: Decodable {
    let places: [Place]

    enum CodingKeys: String, CodingKey {
        case places = "results"
    }
}

struct Place: Decodable {
    let id: String
    let name, address: String
    let priceLevel: Int?
    let rating: Double
    let photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case address = "formatted_address"
        case priceLevel = "price_level"
        case rating, name, photos
    }
}
