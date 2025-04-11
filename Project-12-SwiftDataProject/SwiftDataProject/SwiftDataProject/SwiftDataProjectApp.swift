import SwiftUI
import SwifData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
        .modelContainer(for: User.self)
}
