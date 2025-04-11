import Foundation
import _MapKit_SwiftUI
import MapKit
import CoreLocation
import LocalAuthentication

extension ContentView {
    @Observable
    class ViewModel {
        
        private(set) var locations: [Location] //This line declares an array named locations that will hold objects of type Location.
        var selectedPlace: Location?
        var isUnlocked = false
        var mapType: Int = 0 // Current Project Challlenge 1
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        var selectedMapStyle: MapStyle { // Current Project Challlenge 1
            return switch(mapType) {
            case 0: .standard
            case 1: .hybrid
            default: .standard
            }
        }
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D){
            // If the conversion is successful, a new Location object is created.
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            
            /* Finally, the new Location object is appended to locations array. This triggers UI update,
             and a new marker appears on the map at the tapped location. */
            locations.append(newLocation) // append a new Location object to the locations array
            save()
        }
        
        func update(location: Location){
            guard let selectedPlace else {return}
            if let index = locations.firstIndex(of: selectedPlace) {// then looks up where the current location is
                locations[index] = location //and replaces it with new location in the array.
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            // Ask it whether the current device is capable of biometric authentication.
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                //If it is, start the request and provide a closure to run when it completes.
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    success, authenticationError in
                    
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                        if let authenticationError = authenticationError { // Current Project Challlenge 2
                            print("Authentication failed with error: \(authenticationError.localizedDescription)")
                        }
                    }
                }
            } else {
                // no biometrics
                if let error = error { // Current Project Challlenge 2
                    print("Biometric authentication is not available: \(error.localizedDescription)")
                }
            }
        }
    }
}

