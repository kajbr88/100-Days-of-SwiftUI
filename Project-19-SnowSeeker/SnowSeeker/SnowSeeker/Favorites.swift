import SwiftUI

// @Observable
class Favorites: ObservableObject  {
    // the actual resorts the user has favorited
    private var resorts: Set<String>
    
    // the key we're using to read/write in UserDefaults
    private let key = "Favorites"
    
    init() {
        // load our saved data
        if let data = UserDefaults.standard.data(forKey: key) { //Current Project Challenge 2
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }
        //if no data exists then initialize an empty Set.
        resorts = []
    }
    
    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // adds the resort to our set and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()/*objectWillChange.send() is used to notify SwiftUI that the data in the 
Favorites class is about to change and ensures UI remains synchronized with the data in the Favorites class.*/
        resorts.insert(resort.id)
        save()
    }
    
    // removes the resort from our set and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write out our data
        if let encoded = try? JSONEncoder().encode(resorts) { //Current Project Challenge 2
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
