import SwiftUI

struct CrewHScrollView: View { // Challenge 2 for Current Project#8 
    
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) { /* Astronaut details are outside of Mission Highlights because they go from edge to edge unlike VStack. */
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {			
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                                 .accessibilityHidden(true) // Accessibility Project #15 Challenge 3 
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                        .accessibilityElement()  // Accessibility Project #15 Challenge 3 
                        .accessibilityLabel("\(crewMember.astronaut.name), \(crewMember.role)")
                    }
                }
            }
        }
    }
}

struct CrewHScrollView_Previews: PreviewProvider {
     static var previews: some View {
        HStack {
            CrewHScrollView(
                crew: [
                    MissionView.CrewMember(
                        role: "Commander",
                        astronaut: Astronaut(
                            id: "armstrong",
                            name: "Neil A. Armstrong",
                            description: "")
                    ),
                ]
            )
        }
        .preferredColorScheme(.dark)
    }
}
