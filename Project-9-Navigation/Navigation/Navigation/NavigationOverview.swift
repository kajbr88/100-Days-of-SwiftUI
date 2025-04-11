// The problem with a simple NavigationLink – Navigation SwiftUI Tutorial 1/9

import SwiftUI

// struct DetailView: View {
//     var number: Int

//     var body: some View {
//         Text("Detail View \(number)")
//     }

//     init(number: Int) {
//         self.number = number
//         print("Creating detail view \(number)")
//     }
// }

// struct NavigationOverview: View {
//     var body: some View {
//         NavigationStack {
//             List(0..<1000) { i in
//                 NavigationLink("Tap Me") { // "Tap Me" is navigation label
//                     DetailView(number: i) // Destination View
//                 }
//             }
//         }
//     }
// }

// struct NavigationOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         NavigationOverview()
//     }
// }




// Handling navigation the smart way with navigationDestination() – Navigation SwiftUI Tutorial 2/9

// struct Student: Hashable {
//     var id = UUID()
//     var name: String
//     var age: Int
// }

// struct NavigationOverview: View {
//     var body: some View {
//         NavigationStack {
//             List(0..<100) { i in
//                 NavigationLink("Select \(i)", value: i)
//             }
//             .navigationDestination(for: Int.self) { selection in /*  If you have several different
//              types of data to navigate to them, just add several navigationDestination() modifiers. In 
//              effect you're saying, "do this when you want to navigate to an integer, but do that when
//               you want to navigate to a string." */ 
//                 Text("You selected \(selection)")
//             }
//             .navigationDestination(for: Student.self) { student in 
//                 Text("You selected \(student.name)")
//             }
//         }
//     }
// }

// struct NavigationOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         NavigationOverview()
//     }
// }




// Programmatic navigation with NavigationStack – Navigation SwiftUI Tutorial 3/9

// struct NavigationOverview: View {
//     @State private var path = [Int]() // Property to store the path were working with out navigation.

//     var body: some View {
//         NavigationStack(path: $path) { // changing the array will naigate to whatever is used inside the array.
//             VStack {
//                 Button( "Show 32") {
//                     path = [32]
//                 }

//                 Button("Show 64") {
//                     path.append(64)
//                 }

//                 Button("Show 32 then 64") {
//                     path = [32, 64]
//                 }
//             }
//             .navigationDestination(for: Int.self) { selection in
//                 Text("You selected \(selection)")
//             }
//         }
//     }
// }

// struct NavigationOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         NavigationOverview()
//     }
// }




// Navigating to different data types using NavigationPath – Navigation SwiftUI Tutorial 4/9

// struct NavigationOverview: View {
//     @State private var path = NavigationPath() /* NavigationPath is what we call a type-eraser – it 
//     stores any kind of Hashable data without exposing exactly what type of data each item is. */

//     var body: some View {
//         NavigationStack(path: $path) {
//             List {
//                 ForEach(0..<5) { i in
//                     NavigationLink("Select Number: \(i)", value: i)
//                 }

//                 ForEach(0..<5) { i in
//                     NavigationLink("Select String: \(i)", value: String(i))
//                 }
//             }
//             .toolbar {
//                 Button("Push 556") {
//                     path.append(556)
//                 }

//                 Button("Push Hello") {
//                     path.append("Hello")
//                 }
//             }
//             .navigationDestination(for: Int.self) { selection in
//                 Text("You selected the number \(selection)")
//             }
//             .navigationDestination(for: String.self) { selection in
//                 Text("You selected the string \(selection)")
//             }
//         }
//     }
// }

// struct NavigationOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         NavigationOverview()
//     }
// }




// How to make a NavigationStack return to its root view – Navigation SwiftUI Tutorial 5/9

//struct DetailView: View {
//    var number: Int
//    @Binding var path: [Int]
//    // @Binding var path: NavigationPath()
//
//    var body: some View {
//        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
//            .onAppear {
//                print("Paths:", path)
//            }
//            .navigationTitle("Number: \(number)")
//            .toolbar {
//                Button("Home") {
//                    // path.removeAll()
//                    path = NavigationPath()
//
//                }
//            }
//    }
//}
//
//struct NavigationOverview: View {
//    // @State private var path = [Int]()
//    @State private var path = NavigationPath()
//    var body: some View {
//
//        NavigationStack(path: $path) {
//            DetailView(number: 0, path: $path) // DetailView is displayed with number 0.
//
//                .navigationDestination(for: Int.self) { i in
//                    DetailView(number: i, path: $path) /* Tapping the "Go to Random Number"
//button triggers the NavigationLink. In turn this DetailView is pushed onto the navigation stack
//with a random number. */
//                }
//        }
//    }
//}
//
//struct NavigationOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationOverview()
//    }
//}





// How to save NavigationStack paths using Codable – Navigation SwiftUI Tutorial 6/9

// import Combine // use this import for iOS 16 and below and remove Observation.
// //import Observation // use this import for iOS 17 and obove and remove Combine.

// /* for iOS 17 and above remove ObservableObject protocol and use @Observable here in this 
// line and remove @Published for properties of this class( in observed class) & change @StateObject for the 
// updating property in ContentView to @State, and also import Observation. */
// class PathStore : ObservableObject{
//     // var path: [Int] {
//     @Published var path: NavigationPath {
//         didSet { // didSet a property observer executes whenever path var changes.
//             save()
//         }
//     }
//     // path to write things out.
//     private let savePath = URL.documentsDirectory.appending(path: "SavedPath") 

//     init() { /* loads the data back out from disk and putting it into the path array */
//         if let data = try? Data(contentsOf: savePath) { 
//           if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, 
//           from: data) {// decode from JSON to NavigationPath type
//           path = NavigationPath(decoded) /* set path to decoded array for [Int] or (decoded gives
// and object here which can be used to createa a NavigationPath) */
//                 return
//             }
//         }
//         // Still here? Start with an empty path.
//         path = NavigationPath() 
//     }

//     func save() {
//         guard let representation = path.codable else { return }

//         do {
//             let data = try JSONEncoder().encode(representation)// encodes path array to JSON data.
//             try data.write(to: savePath)
//         } catch {
//             print("Failed to save navigation data")
//         }
//     }
// }

// struct DetailView: View {
//     var number: Int
//     // @Binding var path: [Int]
//     // @Binding var path: NavigationPath()

//     var body: some View {
//         NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
//             // .onAppear {
//             //     print("Paths:", path)
//             // }
//             .navigationTitle("Number: \(number)")
// //            .toolbar {
// //                Button("Home") {
// //                    // path.removeAll()
// //                    path = NavigationPath()
// //                }
// //            }
//     }
// }

// struct NavigationOverview: View {
//     // @State private var path = [Int]()
//     @StateObject private var pathStore = PathStore()

//     var body: some View {
//         NavigationStack(path: $pathStore.path) { /* binding to pathStore.path to get the loading 
// and saving happening when new view like detailView is created again and again. */
//             DetailView(number: 0) // DetailView is displayed with number 0.
//                 .navigationDestination(for: Int.self) { i in
//                     DetailView(number: i) /* Tapping the "Go to Random Number" 
// button triggers the NavigationLink. In turn this DetailView is pushed onto the navigation stack 
// with a random number. */
//                 }
//         }
//     }
// }

// struct NavigationOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         NavigationOverview()
//     }
// }





// Customizing the navigation bar appearance – Navigation SwiftUI Tutorial 7/9

//struct NavigationOverview: View {
//    var body: some View {
//        NavigationStack {
//            List(0..<100) { i in
//                Text("Row \(i)")
//            }
//            .navigationTitle("Title goes here")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(.blue)
//            .toolbarColorScheme(.dark)
//        }
//    }
//}
//
//struct NavigationOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationOverview()
//    }
//}





// Placing toolbar buttons in exact locations – Navigation SwiftUI Tutorial 8/9

// struct NavigationOverview: View {
//     var body: some View {
//         NavigationStack {
//             Text("Hello, world!")
//                 .toolbar {
//                     ToolbarItemGroup(placement: .confirmationAction) {
//                         Button("Tap Me") {
//                             // button action here
//                         }
//
//                         Button("Tap Me 2") {
//                             // button action here
//                         }
//                     }
//                 }
//         }
//     }
// }
//
// struct NavigationOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         NavigationOverview()
//     }
// }





// Making your navigation title editable – Navigation SwiftUI Tutorial 9/9

struct NavigationOverview: View {
    @State private var title = "SwiftUI"

    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NavigationOverview_Previews: PreviewProvider {
    static var previews: some View {
        NavigationOverview()
    }
}
