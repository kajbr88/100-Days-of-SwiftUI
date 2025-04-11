import SwiftUI
import CoreData//Coredata needs to be imported here to use NSManagedObject.

    struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>//just store the fetch request, we don’t create the fetch request here.
    
    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)// call to content closure passing in the item.
        }
    }
//@ViewBuilder lets our containing view (whatever is using the list) send in multiple views if they want.
//@escaping says the closure will be stored away and used later, which means Swift needs to take care of its memory.
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: 
            "%K BEGINSWITH %@", filterKey, filterValue))//NSPredicate has a special symbol that can be used to replace attribute names: %K, for “key”. This will insert values we provide, but won’t add quote marks around them like %@ does. 
        self.content = content
    }
}