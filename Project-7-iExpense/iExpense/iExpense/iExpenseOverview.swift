//// Using @State with classes – iExpense SwiftUI Tutorial 1/11
//import SwiftUI
//
//@Observable
//class User {
//    var firstName = "Bilbo"
//    var lastName = "Baggins"
//}
//
//struct iExpenseOverview: View {
//    @State private var user = User() /* view dosent reload with change in var inside the User class as @State
//    is not designed to moniter changes inside the class only works with struct. */
//
//    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName)")
//
//            TextField("First name", text: $user.firstName)
//            TextField("Last name", text: $user.lastName)
//        }
//        .padding()
//    }
//}
//
//struct iExpenseOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        iExpenseOverview()
//    }
//}




//// Using SwiftUI state with @Observable – iExpense SwiftUI Tutorial 2/11
//import Observation // adding this import allows us to see inside the macro @Observable using cmd+click.
//import SwiftUI
//
//@Observable
//class User {
//    var firstName = "Bilbo"
//    var lastName = "Baggins"
//}
//
//struct iExpenseOverview: View {
//    @State private var user = User() /* @State dosent work with change in var inside the User class as @State
//    is not designed to moniter changes inside the class it only works with variable struct*/
//
//    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName).")
//
//            TextField("First name", text: $user.firstName)
//            TextField("Last name", text: $user.lastName)
//        }
//        .padding()
//    }
//}
//
//struct iExpenseOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        iExpenseOverview()
//    }
//}




//// Showing and hiding views – iExpense SwiftUI Tutorial 3/11
//
//import SwiftUI
//
//struct SecondView: View {
//    @Environment(\.dismiss) var dismiss
//    let name: String
//
//    var body: some View {
//        Button("Dismiss") {
//            dismiss()
//        }
//    }
//}
//
//    struct iExpenseOverview: View {
//        @State private var showingSheet = false
//
//        var body: some View {
//            Button("Show Sheet") {
//                showingSheet.toggle()
//            }
//            .sheet(isPresented: $showingSheet) {
//                SecondView(name: "@Second Page")
//            }
//        }
//    }
//
//    struct iExpenseOverview_Previews: PreviewProvider {
//        static var previews: some View {
//            iExpenseOverview()
//        }
//    }




// Deleting items using onDelete() – iExpense SwiftUI Tutorial 4/11

// import SwiftUI

// struct iExpenseOverview: View {
//     @State private var numbers = [Int]()
//     @State private var currentNumber = 1

//     func removeRows(at offsets: IndexSet) {
//     numbers.remove(atOffsets: offsets)
// }
//     var body: some View {
//         NavigationStack {
//         VStack {
//             List {
//                ForEach(numbers, id: \.self) {
//     Text("Row \($0)")
// }.onDelete(perform: removeRows)
//             }

//             Button("Add Number") {
//                 numbers.append(currentNumber)
//                 currentNumber += 1
//             }
//         }
//     }.toolbar {
//     EditButton()
// }

// }

//  struct iExpenseOverview_Previews: PreviewProvider {
//         static var previews: some View {
//             iExpenseOverview()
//         }
//     }




// Storing user settings with UserDefaults – iExpense SwiftUI Tutorial 5/11

// import SwiftUI

// struct iExpenseOverview: View {
// //    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
//     @AppStorage("tapCount") private var tapCount = 0 // @AppStorage is used for complex data.
//     var body: some View {
//         Button("Tap count: \(tapCount)") {
//             tapCount += 1
// /*            UserDefaults.standard.set(tapCount, forKey: "Tap") // UserDefaults is used for simple data like int, boolean */
//         }
//     }
// }

//   struct iExpenseOverview_Previews: PreviewProvider {
//         static var previews: some View {
//             iExpenseOverview()
//         }
//     }




// Archiving Swift objects with Codable – iExpense SwiftUI Tutorial 6/11

import SwiftUI

struct User: Codable {
    let firstName: String
    let lastName: String
}

struct iExpenseOverview: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct iExpenseOverview_Previews: PreviewProvider {
    static var previews: some View {
        iExpenseOverview()
    }
}
