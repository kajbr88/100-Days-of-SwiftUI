import Foundation

struct Mission: Codable, Identifiable, Hashable {
    
    struct CrewRole: Codable, Hashable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {/* this method needs to be used here as "launchDate" property can be nil but The nil-coalescing operator "??" needs same types on both side. */
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
