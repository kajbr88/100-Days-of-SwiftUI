import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem { //to show everyone that you met.
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem { // to show people you have contacted.
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem { // another to show people you haven’t contacted.
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView() // for showing your personal information for others to scan.
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
