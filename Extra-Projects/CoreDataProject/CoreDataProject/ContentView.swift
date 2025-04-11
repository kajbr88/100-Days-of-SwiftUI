import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc/*This injects the managed object context into the
environment, allowing you to interact with Core Data. The @Environment(\.managedObjectContext) 
property wrapper allows views to "tap into" the environment and retrieve the injected NSManagedObjectContext.*/

    //Auto fetch code
//     @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == 'Star Wars'")) var ships: FetchedResults<Ship>
// /*The code assumes you have a
// Wizard entity(class) defined in your Core Data model with a name attribute(property).*/
// /*@FetchRequest fetches all Wizard objects from Core Data and stores them in the wizards property.*/
@State private var lastNameFilter = "A"//some state we can use as a filter.

    var body: some View {
        VStack {
    FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
}

    Button("Add Examples") {
        let taylor = Singer(context: moc)
        taylor.firstName = "Taylor"
        taylor.lastName = "Swift"

        let ed = Singer(context: moc)
        ed.firstName = "Ed"
        ed.lastName = "Sheeran"

        let adele = Singer(context: moc)
        adele.firstName = "Adele"
        adele.lastName = "Adkins"

        try? moc.save()
    }

    Button("Show A") {
        lastNameFilter = "A"
    }

    Button("Show S") {
        lastNameFilter = "S"
    }
}
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
