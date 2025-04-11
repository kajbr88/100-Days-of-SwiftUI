// Introduction to SwiftData and SwiftUI – Bookworm SwiftUI Tutorial 3/10

// import SwiftUI
// import SwiftData

// struct ContentView: View {
//     @Environment(\.modelContext) var modelContext //Property to access the model context that was created earlier.
//     @Query var students: [Student] /*Retrieving information from SwiftData is done using a query – we 
//     describe what we want, how it should sorted, and whether any filters should be used, and SwiftData
//      sends back all the matching data. We need to make sure that this query stays up to date over time, 
//      so that as students are created or removed our UI stays synchronized.*/

//     var body: some View {
//         NavigationStack {
//             List(students) { student in
//                 Text(student.name)
//             }
//             .navigationTitle("Classroom")
//             .toolbar {
//                 Button("Add") { /* This button adds a new random student every time it’s tapped.*/
//                     let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
//                     let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

//                     let chosenFirstName = firstNames.randomElement()!
//                     let chosenLastName = lastNames.randomElement()!

//                     let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
//                     modelContext.insert(student)
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


import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext //Property to access the model context that was created earlier.
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    /*Retrieving information from SwiftData is done using a query – we
     describe what we want, how it should sorted, and whether any filters should be used, and SwiftData sends back all the matching data. We need to make sure that this query stays up to date over time, so that as students are created or removed our UI stays synchronized.*/
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {		
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .modifier(Custom(book: book)) // Current Project Challenge 2
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our query
            let book = books[offset]
            
            // delete it from the context
            modelContext.delete(book)
        }
    }
    
    struct Custom: ViewModifier {
        let book: Book
        
        func body(content: Content) -> some View {
            content
                .foregroundColor(getColor())
        }
        
        func getColor() -> Color { // Current Project Challenge 2
            if(book.rating == 1) {
                return Color.red
            }
            else {
                return Color.black
            }
        }
    }
}

#Preview {
    ContentView()
}

