// Creating a custom component with @Binding – Bookworm SwiftUI Tutorial 1/10

// import SwiftUI

// struct PushButton: View {
//     let title: String
//     @Binding var isOn: Bool

//     var onColors = [Color.red, Color.yellow]
//     var offColors = [Color(white: 0.6), Color(white: 0.4)]

//     var body: some View {
//         Button(title) {
//             isOn.toggle()
//         }
//         .padding()
//         .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
//         .foregroundStyle(.white)
//         // .clipShape(.capsule) // iOS 17 and above
//         .shadow(radius: isOn ? 0 : 5)
//     }
// }

// struct BookwormOverview: View {
//     @State private var rememberMe = false

//     var body: some View {
//         VStack {
//             PushButton(title: "Remember Me", isOn: $rememberMe)
//             Text(rememberMe ? "On" : "Off")
//         }
//     }
// }

// struct BookwormOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         BookwormOverview()
//     }
// }




// Accepting multi-line text input with TextEditor – Bookworm SwiftUI Tutorial 2/10

// import SwiftUI

// struct BookwormOverview: View {
//     @AppStorage("notes") private var notes = "a"

//     var body: some View {
//         NavigationStack {
//             TextField("Enter your text", text: $notes, axis: .vertical)
//                 .textFieldStyle(.roundedBorder)
//                 .navigationTitle("Notes")
//                 .padding()
//         }
//     }
// }

// struct BookwormOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         BookwormOverview()
//     }
// }
