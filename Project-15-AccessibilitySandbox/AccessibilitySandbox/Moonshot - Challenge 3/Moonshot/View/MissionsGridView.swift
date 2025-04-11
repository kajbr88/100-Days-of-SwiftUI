import SwiftUI

struct MissionsGridView: View {         // Challenge 3 for Current Project#8
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                                .accessibilityElement() // Accessibility Project #15 Challenge 3
                                .accessibilityHidden(true)
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                        .accessibilityElement() // Accessibility Project #15 Challenge 3 
                        .accessibilityLabel("\(mission.displayName), \(mission.formattedLaunchDate)")
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationDestination(for: Mission.self) {  // Project 9 Navigation - Challenge 3
                MissionView(mission: $0, astronauts: astronauts)
            }
        }
    }
}


struct MissionsGridView_Previews: PreviewProvider {
   static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
   static let missions: [Mission] = Bundle.main.decode("missions.json")
   
   static var previews: some View {
       MissionsGridView(astronauts: astronauts, missions: missions)
   }
}
