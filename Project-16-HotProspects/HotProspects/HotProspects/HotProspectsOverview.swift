// Letting users select items in a List – Hot Prospects 1/16

//import SwiftUI
//
//struct HotProspectsOverview: View {
//    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
//    @State private var selection = Set<String>()
//
//    var body: some View {
//        List(users, id: \.self, selection: $selection) { user in
//            Text(user)
//        }
//
//        if selection.isEmpty == false {
//            Text("You selected \(selection.formatted())")
//        }
//
//        EditButton()
//    }
//}
//
//struct HotProspectsOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        HotProspectsOverview()
//    }
//}






// Creating tabs with TabView and tabItem() – Hot Prospects 2/16

// import SwiftUI

// struct HotProspectsOverview: View {
//         @State private var selectedTab = "One"

//     var body: some View {
//         TabView(selection: $selectedTab) {
//             Button("Show Tab 2") {
//                 selectedTab = "Two"
//             }
//             .tabItem {
//                 Label("One", systemImage: "star")
//             }
//             .tag("One")

//             Text("Tab 2")
//                 .tabItem {
//                     Label("Two", systemImage: "circle")
//                 }
//                 .tag("Two")
//         }
//     }
// }

// struct HotProspectsOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         HotProspectsOverview()
//     }
// }





// Understanding Swift’s Result type – Hot Prospects 3/16
//
//import SwiftUI
//
//struct HotProspectsOverview: View {
//    @State private var output = ""
//
//    var body: some View {
//        Text(output)
//            .task {
//                await fetchReadings()
//            }
//    }
//
//    func fetchReadings() async {
//        let fetchTask = Task {
//            let url = URL(string: "https://hws.dev/readings.json")!
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let readings = try JSONDecoder().decode([Double].self, from: data)
//            return "Found \(readings.count) readings"
//        }
//
//        let result = await fetchTask.result
//
////        do {
////            output = try result.get()
////        } catch {
////            output = "Error: \(error.localizedDescription)"
////        }
//
//        switch result {
//        case .success(let str):
//            output = str
//        case .failure(let error):
//            output = "Error: \(error.localizedDescription)"
//        }
//    }
//}
//
//struct HotProspectsOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        HotProspectsOverview()
//    }
//}





// Controlling image interpolation in SwiftUI – Hot Prospects 4/16

// import SwiftUI

// struct HotProspectsOverview: View {

//     var body: some View {
//         Image(.example)
//             .interpolation(.none)    
//             .resizable() //to scale up
//             .scaledToFit() // to keep the aspect ration
//             .background(.black)
//     }
// }

// struct HotProspectsOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         HotProspectsOverview()
//     }
// }





// Creating context menus – Hot Prospects 5/16

// import SwiftUI

// struct HotProspectsOverview: View {
//     @State private var backgroundColor = Color.red

//     var body: some View {
//         VStack {
//             Text("Hello, World!")
//                 .padding()
//                 .background(backgroundColor)

//             Text("Change Color")
//                 .padding()
//                 .contextMenu {
//                     Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
//                         backgroundColor = .red
//                     }

//                     Button("Green") {
//                         backgroundColor = .green
//                     }

//                     Button("Blue") {
//                         backgroundColor = .blue
//                     }
//                 }
//         }
//     }
// }

// struct HotProspectsOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         HotProspectsOverview()
//     }
// }






// Adding custom row swipe actions to a List – Hot Prospects 6/16

// import SwiftUI

// struct HotProspectsOverview: View {

//     var body: some View {
//         List {
//             Text("Taylor Swift")
//                 .swipeActions {
//                     Button("Delete", systemImage: "minus.circle", role: .destructive) {
//                         print("Deleting")
//                     }
//                 }
//                 .swipeActions(edge: .leading) {
//                     Button("Pin", systemImage: "pin") {
//                         print("Pinning")
//                     }
//                     .tint(.orange)
//                 }
//         }
//     }
// }

// struct HotProspectsOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         HotProspectsOverview()
//     }
// }






// Scheduling local notifications – Hot Prospects 7/16

// import SwiftUI
// import UserNotifications

// struct HotProspectsOverview: View {
//     @State private var backgroundColor = Color.red

//     var body: some View {
//         VStack {
//             Button("Request Permission") {
//                 UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                     if success {
//                         print("All set!")
//                     } else if let error {
//                         print(error.localizedDescription)
//                     }
//                 }
//             }

//             Button("Schedule Notification") {
//                 let content = UNMutableNotificationContent()
//                 content.title = "Feed the cat"
//                 content.subtitle = "It looks hungry"
//                 content.sound = UNNotificationSound.default

//                 // show this notification five seconds from now
//                 let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

//                 // choose a random identifier combine content and trigger into a single request object.
//                 let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

//                 // add our notification request- to tell iOS, show this at some point in the future.
//                 UNUserNotificationCenter.current().add(request)
//             }
//         }
//     }
// }

// struct HotProspectsOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         HotProspectsOverview()
//     }
// }





// Adding Swift package dependencies in Xcode – Hot Prospects 8/16

import SwiftUI
import SamplePackage

 struct HotProspectsOverview: View {
    
     let possibleNumbers = 1...60
    
     var results: String {
         let selected = possibleNumbers.random(7).sorted() // pick random numbers and sort them.
         let strings = selected.map(String.init) // stringify them.
         return strings.formatted() // join them with commas.
     }
    
     var body: some View {
         Text(results)
     }
 }

 struct HotProspectsOverview_Previews: PreviewProvider {
     static var previews: some View {
         HotProspectsOverview()
     }
 }

