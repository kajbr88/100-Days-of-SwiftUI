import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject2")/*"container" is the NSPersistentContainer instance within DataController, which represents the entire Core Data stack. this line initializes the NSPersistentContainer with the datamadel named CoreDataProject.*/
    
    init() {
        container.loadPersistentStores { description , error in
            if let error = error{
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump//sets the merge policy for the viewContext of a Core Data stack.
        }
    }
}
