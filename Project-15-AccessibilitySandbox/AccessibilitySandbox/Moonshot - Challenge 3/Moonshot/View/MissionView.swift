import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                // .containerRelativeFrame(.horizontal) { width, axis in /* works in iOS 17 & above.*/
                //      width * 0.6
                // }
                    .accessibilityHidden(true) // Accessibility Project #15 Challenge 3 
                
                Text("Launch Date : \(mission.formattedLaunchDate)") // Challenge 1 for Current Project#8
                .font(.headline.bold())
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .strokeBorder(.white, lineWidth: 0.5)
                                .opacity(0.5)
                        )
                        .padding(.top, 15)

                VStack(alignment: .leading) {
                    RectangleDivider()      // Challenge 2 for Current Project#8
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    RectangleDivider()      // Challenge 2 for Current Project#8
            	        
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                CrewHScrollView(crew: crew) // Challenge 2 for Current Project#8
            }
            .padding(.bottom)
            .accessibilityElement() // Accessibility Project #15 Challenge 3 
            .accessibilityLabel("\(mission.description), \(mission.formattedLaunchDate)")
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
         let missions: [Mission] = Bundle.main.decode("missions.json")
         let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        
         return MissionView(mission: missions[0], astronauts: astronauts)
             .preferredColorScheme(.dark)
    }
}
