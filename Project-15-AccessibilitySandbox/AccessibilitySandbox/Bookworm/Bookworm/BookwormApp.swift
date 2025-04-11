import SwiftUI
import SwiftData

@main /*The @main line tells Swift this is what launches our app. Internally this is what bootstraps the 
whole program when the user launches our app from the iOS Home Screen.*/
struct BookwormApp: App { //App Struct, it acts as the launch pad for the whole app we're running.
    var body: some Scene {
        WindowGroup {/*The WindowGroup part tells SwiftUI that our app can be displayed in many windows. 
        This doesn't do much on iPhone, but on iPad and macOS it becomes a lot more important.*/
            ContentView()
        //  BookwormOverview()
        }
        // .modelContainer(for: Student.self)
        .modelContainer(for: Book.self)/*we need to add a modifier to the WindowGroup so that 
        SwiftData is available everywhere in our app:*/
        /*Every SwiftData app needs a model context to work with, and we've already created ours – it's 
        created automatically when we use the modelContainer() modifier. SwiftData automatically creates 
        one model context for us, called the main context, and stores it in SwiftUI's environment,*/
    }
}
