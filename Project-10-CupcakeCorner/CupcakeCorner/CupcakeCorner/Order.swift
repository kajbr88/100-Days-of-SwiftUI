import Foundation
import Combine // for iOS 16 and below.

// @Observable // for iOS 17 and above.
class Order: ObservableObject, Codable {
    
    enum CodingKeys: String, CodingKey { // iOS 16 and below.
        case type, quantity, specialRequestEnabled, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    //    enum CodingKeys: String, CodingKey { // for iOS 17 and above.
    //        case _type = "type"
    //        case _quantity = "quantity"
    //        case _specialRequestEnabled = "specialRequestEnabled"
    //        case _extraFrosting = "extraFrosting"
    //        case _addSprinkles = "addSprinkles"
    //        case _name = "name"
    //        case _city = "city"
    //        case _streetAddress = "streetAddress"
    //        case _zip = "zip"
    //    }
    
    
    init() {
       if let dataName = UserDefaults.standard.data(forKey: "addressItems") { // Current project Challenge 3
           if let decodedName = try? JSONDecoder().decode([String].self, from: dataName) {
               name = decodedName[0]
               streetAddress = decodedName[1]
               city = decodedName[2]
               zip = decodedName[3]
               return
           }
       }

       name = ""
       streetAddress = ""
       city = ""
       zip = ""
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    func encode(to encoder: Encoder) throws {
        var containter = encoder.container(keyedBy: CodingKeys.self)
        
        try containter.encode(type, forKey: .type)
        try containter.encode(quantity, forKey: .quantity)
        try containter.encode(extraFrosting, forKey: .extraFrosting)
        try containter.encode(addSprinkles, forKey: .addSprinkles)
        try containter.encode(name, forKey: .name)
        try containter.encode(streetAddress, forKey: .streetAddress)
        try containter.encode(city, forKey: .city)
        try containter.encode(zip, forKey: .zip)
    }
    
    static let types = ["Vannila", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool { // Current Project Challenge 1
        if name.isEmptyOrWhitespace() || streetAddress.isEmptyOrWhitespace() || city.isEmptyOrWhitespace() || zip.isEmptyOrWhitespace() {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
}

extension String { // Current Project Challenge 1
    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty) {
            return true
        }
        return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }
}
