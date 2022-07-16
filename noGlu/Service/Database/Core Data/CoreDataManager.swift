import CoreData

struct CoreDataManager: Database {

    private let context: NSManagedObjectContext
    var placesMO: [PlaceMO]? { try? context.fetch(PlaceMO.fetchRequest())}

    init(context: NSManagedObjectContext = CoreDataStack.context) {
        self.context = context
    }

    func fetchImage(with reference: String) -> Data? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceMO")
            fetchRequest.predicate = NSPredicate(format: "reference == %@", reference)
            return (try context.fetch(fetchRequest) as? [PlaceMO])?.first?.blob
        } catch {
            return nil
        }
    }

    func fetchPlace(with reference: String) -> PlaceMO? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceMO")
            fetchRequest.predicate = NSPredicate(format: "reference == %@", reference)
            return (try context.fetch(fetchRequest) as? [PlaceMO])?.first
        } catch {
            return nil
        }
    }

    func createPlace(blob: Data, reference: String, name: String, favorite: Bool = false) {
        context.performAndWait {
            let newPlace = PlaceMO(context: context)
            newPlace.blob = blob
            newPlace.reference = reference
            newPlace.name = name
            newPlace.favorite = favorite
            save()
        }
    }

    func save() {
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
