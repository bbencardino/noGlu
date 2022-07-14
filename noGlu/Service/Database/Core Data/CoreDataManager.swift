import CoreData

struct CoreDataManager: Database {

    private let context: NSManagedObjectContext
    var images: [Image]?

    init(context: NSManagedObjectContext = CoreDataStack.context) {
        self.context = context
    }

    func fetchImage(with reference: String) -> Data? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
            fetchRequest.predicate = NSPredicate(format: "reference == %@", reference)
            return (try context.fetch(fetchRequest) as? [Image])?.first?.blob
        } catch {
            return nil
        }
    }

    func createImage(blob: Data, reference: String) {
        context.performAndWait {
            let newImage = Image(context: context)
            newImage.blob = blob
            newImage.reference = reference
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
