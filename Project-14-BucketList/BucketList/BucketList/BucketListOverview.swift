// Adding conformance to Comparable for custom types – Bucket List SwiftUI Tutorial 1/12

// 1/12.1
import SwiftUI

// struct BucketListOverview: View { 
//     let values = [1, 5, 3, 6, 2, 9].sorted()

//     var body: some View {
//         List(values, id: \.self) {
//             Text(String($0))
//         }
//     }
// }

// struct BucketListOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         BucketListOverview()
//     }
// }


// 1/12.2

// struct BucketListOverview: View {

// struct User: Identifiable, Comparable {
//    let id = UUID()
//    var firstName: String
//    var lastName: String

//    static func <(lhs: User, rhs: User) -> Bool {
//        lhs.lastName < rhs.lastName
//    }
// }

//    struct ContentView: View {
//    let users = [
//        User(firstName: "Arnold", lastName: "Rimmer"),
//        User(firstName: "Kristine", lastName: "Kochanski"),
//        User(firstName: "David", lastName: "Lister"),
//    ].sorted()

//    var body: some View {
//        List(users) { user in
//            Text("\(user.lastName), \(user.firstName)")
//        }
//    }
// }
// }

// struct BucketListOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        BucketListOverview()
//    }
// }





// Writing data to the documents directory – Bucket List SwiftUI Tutorial 2/12

//    struct BucketListOverview: View {
//         var body: some View {
//            Button("Read and Write") {
//                let data = Data("Test Message".utf8) // get the utf8 encoding of the "Test Message" and provide the pure data.
//                let url = URL.documentsDirectory.appending(path: "message.txt") // data will be written in "message.txt".
//                
//                do {
//                    try data.write(to: url, options: [.atomic, .completeFileProtection]) // write data in "message.txt"
//                    let input = try String(contentsOf: url)
//                    print(input)
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//
//struct BucketListOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        BucketListOverview()
//    }
//}




// Switching view states with enums – Bucket List SwiftUI Tutorial 3/12
//
//enum LoadingState {
//    case loading, success, failed
//}
//
//struct LoadingView: View {
//    var body: some View {
//        Text("Loading...")
//    }
//}
//
//struct SuccessView: View {
//    var body: some View {
//        Text("Success!")
//    }
//}
//
//struct FailedView: View {
//    var body: some View {
//        Text("Failed.")
//    }
//}
//
//struct BucketListOverview: View {
//
//    @State private var loadingState = LoadingState.loading
//
//    var body: some View {
//
//        // if loadingState == .loading {
//        //     LoadingView()
//        // } else if loadingState == .success {
//        //     SuccessView()
//        // } else if loadingState == .failed {
//        //     FailedView()
//        // }
//
//        // or
//
//        switch loadingState {
//        case .loading:
//            LoadingView()
//        case .success:
//            SuccessView()
//        case .failed:
//            FailedView()
//        }
//    }
//}
//
//struct BucketListOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        BucketListOverview()
//    }
//}




// Integrating MapKit with SwiftUI – Bucket List SwiftUI Tutorial 4/12.1

// import MapKit 

// struct BucketListOverview: View {
//     @State private var position = MapCameraPosition.region(
//         MKCoordinateRegion(
//             center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
//             span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//         )
//     )
//     var body: some View {
//         VStack {
//             Map(position: $position)
//                 .mapStyle(.hybrid(elevation: .realistic))
//                 .onMapCameraChange(frequency: .continuous) { context in
//         print(context.region)
//     }

//             HStack(spacing: 50) {
//                 Button("Paris") {
//                     position = MapCameraPosition.region(
//                         MKCoordinateRegion(
//                             center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
//                             span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//                         )
//                     )
//                 }

//                 Button("Tokyo") {
//                     position = MapCameraPosition.region(
//                         MKCoordinateRegion(
//                             center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
//                             span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//                         )
//                     )
//                 }
//             }
//         }
//     }
// }

// struct BucketListOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         BucketListOverview()
//     }
// }



// 12.2

// import MapKit 

// struct Location: Identifiable {
//     let id = UUID()
//     var name: String
//     var coordinate: CLLocationCoordinate2D
// }

// struct BucketListOverview: View {
//     let locations = [
//         Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//         Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
//     ]
//     var body: some View {
//         VStack {
//             Map {
//                 ForEach(locations) { location in
//                     Annotation(location.name, coordinate: location.coordinate) {
//                         Text(location.name)
//                             .font(.headline)
//                             .padding()
//                             .background(.blue)
//                             .foregroundStyle(.white)
//                             .clipShape(.capsule)
//                     }
//                     .annotationTitles(.hidden)
//                 }
//             }
//         }
//     }
// }

// struct BucketListOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         BucketListOverview()
//     }
// }

// 12.3

// import MapKit 

// struct Location: Identifiable {
//     let id = UUID()
//     var name: String
//     var coordinate: CLLocationCoordinate2D
// }

// struct BucketListOverview: View {
//     let locations = [
//         Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//         Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
//     ]
//     var body: some View {
//         VStack {
//             MapReader { proxy in /*In order to get an actual location on the map, we need a special view called MapReader. When you wrap one of these around your map, you'll be handed a special MapProxy object that is able to convert screen locations to map locations and back the other way.*/
//                 Map()
//                     .onTapGesture { position in
//                         if let coordinate = proxy.convert(position, from: .local) { /* .local converts the maps local coordinate space */
//                             print(coordinate)
//                         }
//                     }
//             }
//         }
//     }
// }

// struct BucketListOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         BucketListOverview()
//     }
// }





// Using Touch ID and Face ID with SwiftUI – Bucket List SwiftUI Tutorial 5/12

import LocalAuthentication

struct BucketListOverview: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate) /* The onAppear modifier is designed to execute only once 
during a view's initial appearance. Subsequent view updates due to state changes do not re-trigger it.
thereby avoiding infinite loop. State Changes and Side Effects: If you have side effects that depend on state changes, 
consider using onChange or Task to trigger them only when necessary. */
    }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            // check whether biometric authentication is possible
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // it's possible, so go ahead and use it
                let reason = "We need to unlock your data."
                // authenticate
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    // authentication has now completed
                    if success {
                        isUnlocked = true //  authenticated successfully
                    } else {
/* there was a problem and show error or add a screen that prompts for a passcode then providing 
that as a fallback if biometrics fail, but this is something you need to build yourself as Apple dosent. */
                    }
                }
            } else {
                // no biometrics
            }
        }
    }

#Preview {
        BucketListOverview()
}
