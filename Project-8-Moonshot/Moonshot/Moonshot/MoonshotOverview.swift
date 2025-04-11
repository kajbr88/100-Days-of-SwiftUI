// // Resizing images to fit the available space – Moonshot SwiftUI Tutorial 1/1

import SwiftUI

// struct MoonshotOverview: View {
//     var body: some View {
//         Image(.example)
//             .resizable()
//             .scaledToFit()
//             .containerRelativeFrame(.horizontal) { size, axis in
//                 size * 0.8
//             }
//     }
// }

// struct MoonshotOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         MoonshotOverview()
//     }
// }



// How ScrollView lets us work with scrolling data – Moonshot SwiftUI Tutorial 2/11

// struct CustomText: View {
//     let text: String

//     var body: some View {
//         Text(text)
//     }

//     init(text: String) {
//         print("Creating a new CustomText")
//         self.text = text
//     }
// }

// struct MoonshotOverview: View {
//     var body: some View {
//         ScrollView(.horizontal) {
//             LazyHStack(spacing: 10) {
//                 ForEach(0..<100) {
//                     CustomText(text: "Item \($0)")
//                         .font(.title)
//                 }
//             }
// //            .frame(maxWidth: .infinity)
//         }
//     }
// }

// struct MoonshotOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         MoonshotOverview()
//     }
// }



// Pushing new views onto the stack using NavigationLink – Moonshot SwiftUI Tutorial 3/11

// struct MoonshotOverview: View {
//     var body: some View {
//         // NavigationStack {            // Example 1
//         //     NavigationLink {
//         //         Text("Detail View")
//         //     } label: {
//         //         VStack {
//         //             Text("This is the label")
//         //             Text("So is this")
//         //             Image(systemName: "face.smiling")
//         //         }
//         //         .font(.largeTitle)
//         //     }
//         //     .navigationTitle("SwiftUI")
//         // }

//         NavigationStack {               // Example 2
//             List(0..<100) { row in
//                 NavigationLink("Row \(row)") {
//                     Text("Detail \(row)")
//                 }
//             }
//             .navigationTitle("SwiftUI")
//         }
//     }
// }

// struct MoonshotOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         MoonshotOverview()
//     }
// }




// Working with hierarchical Codable data – Moonshot SwiftUI Tutorial 4/11

// struct User: Codable {
//     let name: String
//     let address: Address
// }

// struct Address: Codable {
//     let street: String
//     let city: String
// }

// struct MoonshotOverview: View {
//     var body: some View {
//         Button("Decode JSON") {
//             let input = """
//     {
//         "name": "Taylor Swift",
//         "address": {
//             "street": "555, Taylor Swift Avenue",
//             "city": "Nashville"
//         }
//     }
//     """
//             let data = Data(input.utf8)
//             let decoder = JSONDecoder()
//             if let user = try? decoder.decode(User.self, from: data) {
//                 print(user.address.street)

//             }
//         }
//     }
// }

// struct MoonshotOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         MoonshotOverview()
//     }
// }



// How to lay out views in a scrolling grid – Moonshot SwiftUI Tutorial 5/11

struct MoonshotOverview: View {
    let layout = [
    GridItem(.adaptive(minimum: 80, maximum: 120)),
]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) { /* LazyHGrid and LazyVGrid is more efficient than normal HGrid and VGrid as they use the full view instead of displaying the current data in view, hence they dont need to expand the view or deallocate and allocate the view again and again. */
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct MoonshotOverview_Previews: PreviewProvider {
    static var previews: some View {
        MoonshotOverview()
    }
}
