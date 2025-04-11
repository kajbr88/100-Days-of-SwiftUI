import Foundation

@Model
class User: {
    var name: String = "Anonymous"
    var city: String = "Uknown"
    var joinDate: Date = Date.now
    @Relationship(deleteRule: .cascade) var jobs: [Job]? = [Job]()

    var unwrappedJobs: [Job] {
    jobs ?? []
}
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
