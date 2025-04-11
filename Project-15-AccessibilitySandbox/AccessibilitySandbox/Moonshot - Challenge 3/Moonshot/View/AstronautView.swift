import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .accessibilityHidden(true) // Accessibility Project #15 Challenge 3 
                
                Text(astronaut.description)
                    .padding()
            }
            .accessibilityElement() // Accessibility Project #15 Challenge 3 
            .accessibilityLabel("\(astronaut.description)")
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        
        return AstronautView(astronaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
    }
}
