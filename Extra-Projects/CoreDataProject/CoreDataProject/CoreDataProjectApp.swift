import SwiftUI
import CoreData

@main
struct CoreDataProjectApp: App {
  @StateObject private var dataController = DataController()/*Creates a single instance of DataController that persists across the app's lifetime.*/

  var body: some Scene {
    WindowGroup {
      ContentView()//from container(NSPersistentContainer) we get viewContext(NSManagedObjectContext) for creating objects store objects, retreival etc.
            .environment(\.managedObjectContext, dataController.container.viewContext)/*dataController.container.viewContext: This part provides the actual NSManagedObjectContext instance.
 
dataController: This is your class that manages the Core Data stack.

container: This is the NSPersistentContainer instance within your DataController, which represents the entire Core Data stack.

viewContext: This is the NSManagedObjectContext associated with the container. It's typically the main context used for most operations in your app NSManagedObjectContext enables loading, saving, updating, deleting...

.environment(\.managedObjectContext, ...): This line does the crucial work of:
  Making th e viewContext available: It places the viewContext into the SwiftUI environment.
  
  Establishing the link: This makes the viewContext accessible to any view within that environment using the @Environment(\.managedObjectContext) property wrapper.

In simpler terms: Imagine the environment as a shared bag. The line you mentioned puts the viewContext into
this bag. Then, any view that needs to interact with Core Data can simply reach into the bag and grab the
viewContext to perform operations like fetching, creating, updating, and deleting data.

This mechanism provides a clean and efficient way to share the managedObjectContext throughout your SwiftUI app without the need for complex data passing or dependency injection*/
    }
  }
}
