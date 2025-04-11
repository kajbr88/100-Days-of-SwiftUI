import Foundation

struct Resort: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)/* makes a new Facility by initializing the name property in Facility with each String element of the Facility array itself (memberwise initialization).*/
    }
    
    //when we use static let for properties, Swift automatically makes them lazy – they don’t get created(initialized) until they are used.
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")// to load all resorts into an array.
    static let example = allResorts[0]//to store the first item in that array
}
