import Foundation

enum ServiceError: Error {
    case badFormattedString
    case serviceError
    case noData
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badFormattedString:
            return "The location you tried to search is not correct. Please try again."
        case .serviceError:
            return "There's a error in the service. Please try again later."
        case .noData:
            return "We're having a problem to show you the places. Please try connecting to a better internet."
        }
    }
}
