// Sending and receiving Codable data with URLSession and SwiftUI – Cupcake Corner SwiftUI Tutorial 1/9

import SwiftUI
//
//struct Response: Codable {
//    var results: [Result]
//}
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}
//
//struct CupcakeCornerOverview: View {
//    @State private var results = [Result]()
//
//    var body: some View {
//        List(results, id: \.trackId) { item in
//            VStack(alignment: .leading) {
//                Text(item.trackName)
//                    .font(.headline)
//                Text(item.collectionName)
//            }
//        }.task {
//            await loadData()
//        }
//    }
//    func loadData() async {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else { /* Creating the URL we want to read & find the songs by taylor swift. */
//            print("Invalid URL")
//            return
//        }
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                results = decodedResponse.results
//            }
//        } catch {
//            print("Invalid data")
//        }
//    }
//}
//
//struct CupcakeCornerOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        CupcakeCornerOverview()
//    }
//}



// Loading an image from a remote server – Cupcake Corner SwiftUI Tutorial 2/9

//struct CupcakeCornerOverview: View {
//    @State private var username = ""
//    @State private var email = ""
//    
//    var body: some View {
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
//            if let image = phase.image {
//                image
//                    .resizable()
//                    .scaledToFit()
//            } else if phase.error != nil {
//                Text("There was an error loading the image.")
//            } else {
//                ProgressView()
//            }
//        }
//        .frame(width: 200, height: 200)
//    }
//}
//
//struct CupcakeCornerOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        CupcakeCornerOverview()
//    }
//}



// Validating and disabling forms – Cupcake Corner SwiftUI Tutorial 3/9

// struct CupcakeCornerOverview: View {
//     @State private var username = ""
//     @State private var email = ""

//     var disableForm: Bool {
//     username.count < 5 || email.count < 5
// }

//     var body: some View {
//         Form {
//             Section {
//                 TextField("Username", text: $username)
//                 TextField("Email", text: $email)
//             }

//             Section {
//                 Button("Create account") {
//                     print("Creating account…")
//                 }
//             }
//             .disabled(disableForm)
//         }
//     }
// }

// struct CupcakeCornerOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }



// Adding Codable conformance to an @Observable class – Cupcake Corner SwiftUI Tutorial 4/9

////@Observable
//class User: ObservableObject, Codable  {
////    enum CodingKeys: String, CodingKey { // works with @Observable
////        case _name = "name"
////    }
//    var name = "Taylor"
//}
//
//struct CupcakeCornerOverview: View {
//    var body: some View {
//        Button("Encode Taylor", action: encodeTaylor)
//    }
//
//    func encodeTaylor() {
//        let data = try! JSONEncoder().encode(User())
//        let str = String(decoding: data, as: UTF8.self)
//        print(str)
//    }
//}
//
//struct CupcakeCornerOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}



// Adding haptic effects – Cupcake Corner SwiftUI Tutorial 5/9

import CoreHaptics

struct CupcakeCornerOverview: View {
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("Tap Me", action: complexSuccess)
            .onAppear(perform: prepareHaptics)
    }
    
    // start Haptic engine
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            
            // create one intense, sharp tap, starting from dull to sharp
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        // and then sharp to dull
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        // convert those above events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

//struct CupcakeCornerOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
