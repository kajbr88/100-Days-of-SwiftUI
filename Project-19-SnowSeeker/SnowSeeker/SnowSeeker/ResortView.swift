import SwiftUI

struct ResortView: View {
    let resort: Resort/* creating property or variable named resort of type Resort dosen' intantiate Resort, it just allows to access the properties and methods of the Resort using dot notaion. In order to initialize any object with values for properties and method proper instance needs to be created. */

    @Environment(\.horizontalSizeClass) var horizontalSizeClass//This property uses the @Environment decorator to access the device's horizontal size class (compact for portrait or regular for landscape).
    @Environment(\.dynamicTypeSize) var dynamicTypeSize//This property uses the @Environment decorator to access the user's preferred text size setting.
    @EnvironmentObject var favorites: Favorites

    @State private var selectedFacility: Facility?//selectedFacility is a Type Declaration hence, we can only Access Properties and Methods of Facility but not initialie it.
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                 ZStack(alignment: .topTrailing) { //Current Project Challenge 1
                    Image(decorative: resort.id)
                        .resizable()
                    .scaledToFit()
                    
                    Text(resort.imageCredit) //Current Project Challenge 1       
                }
                
                HStack {
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)//Sets the maximum text size allowed within this section (needs a specific value filled in for xxxLarge).
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    // Text(resort.facilities, format: .list(type: .and)) /* SwiftUI can show string arrays inside Text views
// by using the format parameter. */
                    //     .padding(.vertical)
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                
                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {//label
                    if favorites.contains(resort) {//action
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented://If selectedFacility is nil, the alert will not be presented, even if showingFacility is set to true. therefore, the nill coalesing is redundant here.
               $showingFacility, presenting: selectedFacility) { _ in//Besides conditional presentation, presenting: selectedFacility also passes the selectedFacility instance i.e. particular object of "Facility" or unwrapped Facility instance there as a parameter to the message closure of the alert.
        } message: { facility in
            Text(facility.description)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: .example)
           .environmentObject(Favorites())
    }
}
