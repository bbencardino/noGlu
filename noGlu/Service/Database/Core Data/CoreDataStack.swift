import CoreData

struct CoreDataStack {

    static let context = persistentContainer.viewContext

    private static let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "noGlu")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
