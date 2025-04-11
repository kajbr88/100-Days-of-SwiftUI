import SwiftUI

//ContentView conforms to the View protocol and to conform to the View protocol in SwiftUI, the core and only requirement is to have a body variable.
struct ContentView: View {/*Every custom type in SwiftUI that conforms to the View protocol must have a body property. Without the body property, a type cannot conform to the View protocol and therefore cannot be used as a view in SwiftUI */
    @State private var searchText = ""
    @State private var sortSelection: SortSelection = .defaultSort //Current Project Challenge 3
    @State private var showingSortOptions = false
    @StateObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    enum SortSelection { //Current Project Challenge 3
        case defaultSort
        case name
        case country
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var sortedResorts: [Resort] { ////Current Project Challenge 3
        switch sortSelection {
        case .defaultSort:
            return filteredResorts
        case .name:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted { $0.country < $1.country }
        }
    }
    
    var body: some View {//body varable conforms to the View protocol and also return a View type and only a single View should be returned.
        NavigationSplitView {//SwiftUI supports up to three views side by side in a single NavigationSplitView.
            List(sortedResorts) { resort in //Current Project Challenge 3
                NavigationLink(value: resort) {// If we have two views in a navigation split view, NavigationLink presents destinations in the secondary view.
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in// (for: Resort.self) indicates the type of object the closure will receive. 
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")//binding values for the user's search text and the prompt(placeholder) to show in the search bar.
            .toolbar {
                ToolbarItem {
                    Button {
                        showingSortOptions = true
                    } label: {
                        Label("Sort Options", systemImage: "line.3.horizontal.decrease.circle") //Current Project Challenge 3
                    }
                }
            }
            .confirmationDialog("Sort order", isPresented: $showingSortOptions) { //Current Project Challenge 3
                Button("Default") { sortSelection = .defaultSort }
                Button("Alphabetical") { sortSelection = .name }
                Button("By Country") { sortSelection = .country }
            }
        } detail: {//Secondary View
            WelcomeView()/*at the beginning The WelcomeView acts as a placeholder for the secondary
view of the NavigationSplitView until a selection is made in the list. Then navigationDestination 
property dynamically controls what is displayed in the secondary view based on the user's selections.*/
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
