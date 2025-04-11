import SwiftUI

struct MissionsListView: View {           // Challenge 3 for Current Project(Moonshot) #8
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List(missions) { mission in
            NavigationLink(value: mission) {  
                HStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .accessibilityHidden(true) // Accessibility Project #15 Challenge 3 
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.leading)
                }
                .accessibilityElement() // Accessibility Project #15 Challenge 3 
                .accessibilityLabel("\(mission.displayName), \(mission.formattedLaunchDate)")
            }
            .listRowBackground(Color.darkBackground)
            .navigationDestination(for: Mission.self) {   // Project #9 Navigation - Challenge 3
                MissionView(mission: $0, astronauts: astronauts)
            }
        }
        .listStyle(.plain)
    }
}

struct MissionsListView_Previews: PreviewProvider {
   static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
   static let missions: [Mission] = Bundle.main.decode("missions.json")
   
   static var previews: some View {
       MissionsListView(astronauts: astronauts, missions: missions)
           .preferredColorScheme(.dark)
   }
}


