// 6/12

// import SwiftUI
// import MapKit

// struct ContentView: View {
//     let startPosition = MapCameraPosition.region( //start position for the map.
//         MKCoordinateRegion(
//             center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
//             span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10) // zoom level.
//         )
//     )

//     @State private var locations = [Location]()//This line declares an array named locations that will hold objects of type Location.

//     var body: some View {
//         MapReader { proxy in /* MapReader view allows to access information about the map,
// such as converting screen coordinates to actual map coordinates. Proxy is a MapProxy object,
// this object provides access to information and functionality related to the underlying map. */
//             Map(initialPosition: startPosition) { /*This nested view displays the map with the
//             initial position set by the startPosition variable.*/
//                 ForEach(locations) { location in /*iterates over the locations array and for each location, it adds a Marker view.*/
//                     // Marker view displays a marker on the map.
//                     Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
//                 }
//             }
//             .onTapGesture { position in // position contain the screen space coordinates.
//                 if let coordinate = proxy.convert(position, from: .local) {/* convert screen coordinates to actual map coordinates. */
//                 // If the conversion is successful, a new Location object is created.
//                     let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
// /* Finally, the new Location object is appended to locations array. This triggers UI update,
// and a new marker appears on the map at the tapped location. */
//                     locations.append(newLocation)
//                 }
//             }
//         }
//     }
// }

// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }




// Improving our map annotations – Bucket List SwiftUI Tutorial 7/12

// import SwiftUI
// import MapKit

// struct ContentView: View {
//     let startPosition = MapCameraPosition.region( //start position for the map.
//         MKCoordinateRegion(
//             center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
//             span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10) // zoom level.
//         )
//     )

//     @State private var locations = [Location]() //This line declares an array named locations that will hold objects of type Location.
//     @State private var selectedPlace: Location?

//     var body: some View {
//         MapReader { proxy in /* MapReader view allows to access information about the map,
// such as converting screen coordinates to actual map coordinates. Proxy is a MapProxy object,
// this object provides access to information and functionality related to the underlying map. */
//             Map(initialPosition: startPosition) { /*This nested view displays the map with the
//                         initial position set by the startPosition variable.*/
//                 ForEach(locations) { location in /*iterates over the locations array and for each location, it adds a Marker view.*/
//                     // Marker/Annotation view displays a marker on the map.
//                     Annotation(location.name, coordinate: location.coordinate) {
//                         Image(systemName: "star.circle")
//                             .resizable()
//                             .foregroundStyle(.red)
//                             .frame(width: 44, height: 44)
//                             .background(.white)
//                             .clipShape(.circle)
//                             .onLongPressGesture {/* onLongPressGesture triggers sheet to as item in sheet is binded to selectedPlace. */
//                                 selectedPlace = location
//                             }
//                     }
//                 }
//             } /* closure code in onTapGesture converts screen space coordinates to map coordinates and creates markers. */
//             .onTapGesture { position in // position contain the screen space coordinates.
//                 if let coordinate = proxy.convert(position, from: .local) {/* convert screen coordinates to actual map coordinates. */
//                     // If the conversion is successful, a new Location object is created.
//                     let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)

// /* Finally, the new Location object is appended to locations array. This triggers UI update,
// and a new marker appears on the map at the tapped location. */
//                     locations.append(newLocation) // append a new Location object to the locations array
//                 }

//             } // in sheet send in the location that was selected, and also handle updating changes.
//             .sheet(item: $selectedPlace) { place in //with "place" parameter we're passing the location into EditView,
// /*So with "place" parameter we're passing the location into EditView, and also passes in a closure to
// run when the Save button is pressed. That accepts the new location, then looks up where the current
// location is and replaces it in the array. This will cause our map to update immediately with the new data.*/
//                 EditView(location: place) { newLocation in //with "place" parameter we're passing the location into EditView, and also passes in a closure to run when the Save button is pressed. That accepts the new location,
//         if let index = locations.firstIndex(of: place) {// then looks up where the current location is
//         locations[index] = newLocation //and replaces it with new location in the array.
//                     }
//                 }
//             }
//         }
//     }
// }

// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }





// Introducing MVVM into your SwiftUI project – Bucket List SwiftUI Tutorial 11/12

import SwiftUI
import MapKit

struct ContentView: View {
    let startPosition = MapCameraPosition.region( //start position for the map.
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10) // zoom level.
        )
    )
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in /* MapReader view allows to access information about the map,
                                  such as converting screen coordinates to actual map coordinates. Proxy is a MapProxy object,
                                  this object provides access to information and functionality related to the underlying map. */
                Map(initialPosition: startPosition) { /*This nested view displays the map with the
                                                       initial position set by the startPosition variable.*/
                    ForEach(viewModel.locations) { location in /*iterates over the locations array and for each location, it adds a Marker view.*/
                        // Marker/Annotation view displays a marker on the map.
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture {/* onLongPressGesture triggers sheet, as item in sheet is binded to selectedPlace. */
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                } 
                .mapStyle(viewModel.selectedMapStyle) // Current Project Challlenge 1
                /*Adds Location - closure code in onTapGesture converts screen space coordinates to map coordinates and creates markers. */
                .onTapGesture { position in // position contain the screen space coordinates.
                    if let coordinate = proxy.convert(position, from: .local) {/* convert screen coordinates to actual map coordinates. */
                        viewModel.addLocation(at: coordinate)
                    }
                    
                } // in sheet we send in the location that was selected, and also handle updating changes.
                .sheet(item: $viewModel.selectedPlace) { place in //with "place" parameter we're passing the selected location into EditView,
                    /*So with "place" parameter we're passing the location into EditView, and also passes in a closure to
                     run when the Save button is pressed. That accepts the new location, then looks up where the current
                     location is and replaces it in the array. This will cause our map to update immediately with the new data.*/
                    EditView(location: place) { //with "place" parameter we're passing the selected-location into EditView, and also passes in a closure to run when the Save button is pressed. That accepts the new location,
                        viewModel.update(location: $0) // $0 is the first default parameter being passed.
                    }
                }
                .toolbar { // Current Project Challlenge 1
                    ToolbarItem(placement: .bottomBar) {
                        Button("Standard mode") {
                            viewModel.mapType = 0
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button("Hybrid mode") {
                            viewModel.mapType = 1
                        }
                    }
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview{
    ContentView()
}
