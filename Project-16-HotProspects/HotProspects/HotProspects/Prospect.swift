import SwiftData

@Model/*SwiftData's @Model macro can only be used on a class, but it means we can share
 nstances of that object in several views to have them all kept up to date automatically. */
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var dateAdded = Date() // ✅ Current Project Challenge 3
    
    
    init(name: String, emailAddress: String, isContacted: Bool, dateAdded: Date) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.dateAdded = dateAdded // ✅ Current Project Challenge 3
    }
    
}
