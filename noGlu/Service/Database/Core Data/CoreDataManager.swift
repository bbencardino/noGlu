import CoreData

struct CoreDataManager: Database {

    private let context: NSManagedObjectContext

    var favoritePlaces: [PlaceMO] {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceMO")
            fetchRequest.predicate = NSPredicate(format: "favorite == %x", true)
            return (try context.fetch(fetchRequest) as? [PlaceMO]) ?? []
        } catch {
            return []
        }
    }

    init(context: NSManagedObjectContext = CoreDataStack.context) {
        self.context = context
    }

    func fetchImage(with reference: String) -> Data? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceMO")
            fetchRequest.predicate = NSPredicate(format: "photoReference == %@", reference)
            return (try context.fetch(fetchRequest) as? [PlaceMO])?.first?.blob
        } catch {
            return nil
        }
    }

    func fetchPlace(with id: String) -> PlaceMO? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceMO")
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            return (try context.fetch(fetchRequest) as? [PlaceMO])?.first
        } catch {
            return nil
        }
    }

    func createPlace(_ place: Place, image: Data) {
        context.performAndWait {
            let newPlace = PlaceMO(context: context)
            newPlace.id = place.id
            newPlace.blob = image
            newPlace.photoReference = place.photos.first?.photoReference
            newPlace.name = place.name
            newPlace.rating = place.rating
            newPlace.priceLevel = Int32(place.priceLevel ?? 0) 
            newPlace.favorite = false
            save()
        }
    }

    func setIsFavorite(_ value: Bool, id: String) {
        guard let place = fetchPlace(with: id) else {
            fatalError("something is really wrong here - you can't toggle favorite a place that doesn't exist")
        }
        place.favorite = value
        save()
    }

    func isFavorite(_ id: String) -> Bool {
        fetchPlace(with: id)?.favorite ?? false
    }

    private func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Can not save context \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
