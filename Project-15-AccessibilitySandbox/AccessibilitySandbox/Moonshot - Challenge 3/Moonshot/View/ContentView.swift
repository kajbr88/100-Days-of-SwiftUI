import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

     @State private var showingGrid = true
//    @AppStorage("showingGrid") private var showingGrid = true

    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    MissionsGridView(astronauts: astronauts, missions: missions)// Challenge 3 for Current Project#8

                } else {
                    MissionsListView(astronauts: astronauts, missions: missions)// Challenge 3 for Current Project#8
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
              .toolbar {      // Challenge 3 for Current Project#8
                Button {
                    withAnimation {
                        showingGrid.toggle()
                    }
                } label: {
                    Image(systemName: showingGrid ? "list.bullet" : "square.grid.2x2")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
