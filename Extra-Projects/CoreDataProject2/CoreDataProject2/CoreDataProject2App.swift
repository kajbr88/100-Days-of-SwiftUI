import SwiftUI
import CoreData

@main
struct CoreDataProject2App: App {
  @StateObject private var dataController = DataController()/*Creates a single instance of DataController that persists across the app's lifetime.*/

  var body: some Scene {
    WindowGroup {
      ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
  }
}
