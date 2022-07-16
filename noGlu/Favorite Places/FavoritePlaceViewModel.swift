import Foundation

final class FavoritePlaceViewModel {
    let database: Database = CoreDataManager()

    func numberOfRows() -> Int { database.favoritePlaces.count }

    func makeFavoritePlaceCellViewModel(for index: Int) -> FavoritePlaceCellViewModel {
        let favoritePlace = database.favoritePlaces[index]
        return FavoritePlaceCellViewModel(favoritePlace: favoritePlace)
    }
}
