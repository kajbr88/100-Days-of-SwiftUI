import Foundation
import SwiftUI
import Combine // use this import for iOS 16 and below and remove Observation.
//import Observation // use this import for iOS 17 and obove and remove Combine.


/* for iOS 17 and above remove ObservableObject protocol and use @Observable here in this line and remove
@Published for properties in observed class & change @StateObject for the updating property in 
ContentView to @State, and also import Observation here */
class Expenses: ObservableObject {
    @Published var itemsPersonal = [ExpenseItem]() { // challenge 3
        // Used for saving data
        didSet { /* didSet is a property observer in Swift that allows you to execute
                  custom code whenever a property's value changes. Here, whenever the items
                  property is assigned a new value, the didSet block will be executed, and the didSet block will be executed. */
            if let encoded = try? JSONEncoder().encode(itemsPersonal ) { /* encodes data in swift Object format to JSON format. */
                UserDefaults.standard.set(encoded, forKey: "ItemsPersonal") /* save data to
key named "ItemsPersonal"(ItemsPersonal type is Object) through UserDefaults mechanism in JSON format. 
UserDeults is suited for simple key-value data queries but not for large datasets or complex
queries. */
            }
        }
    }
    
    @Published var itemsBusiness = [ExpenseItem]() { // challenge 3
        didSet {
            if let encoded = try? JSONEncoder().encode(itemsBusiness) {
                UserDefaults.standard.set(encoded, forKey: "ItemsBusiness")
            }
        }
    }
    
    init() { // to load data when the app relaunches
        if let savedPersonalItems = UserDefaults.standard.data(forKey: "ItemsPersonal") { /* read the saved JSON data from ItemsPersonal key using UserDefaults. */
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedPersonalItems) { /* decode data from JSON format to an array of "ExpenseItem". */
                itemsPersonal = decodedItems /* if successfull put decodedItems in itemsPersonal. */
            } else {
                itemsPersonal = [] /* if either of those two, reading or decoding in init fail, set itemsPersonal or itemsBusiness as an empty array. */
            }
        }
        
        if let savedBusinessItems = UserDefaults.standard.data(forKey: "ItemsBusiness") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedBusinessItems) {
                itemsBusiness = decodedItems
            } else {
                itemsBusiness = []
            }
        }
        //        func addItem(_ item: ExpenseItem) {
        //           itemsPersonal.append(item)
        //            itemsBusiness.append(item) }
    }
}
