import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
           ContentView()
         //   HotProspectsOverview()
        }
        .modelContainer(for: Prospect.self)/* this modifier instructs the WindowGroup to 
create a ModelContainer specifically for the Prospect data model. */
    }
}
