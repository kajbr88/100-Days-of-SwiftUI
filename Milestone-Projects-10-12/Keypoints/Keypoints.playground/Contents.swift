import Foundation
import UIKit

struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
        case age
    }

    var firstName: String
    var lastName: String
    var age: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self) /* uses CodingKeys to read all the possible keys that can be loaded from the JSON file. */
        self.firstName = try container.decode(String.self, forKey: .firstName)
        /* "look in the JSON to find the property matching CodingKeys.firstName, and assign it to our local firstName value." */

        self.lastName = try container.decode(String.self, forKey: .lastName)
        let stringAge = try container.decode(String.self, forKey: .age)
        self.age = Int(stringAge) ?? 0
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(String(self.age), forKey: .age)
    }
}

let str = """
{
    "first": "Andrew",
    "last": "Glouberman"
    "age": "13"
}
"""
let data = Data(str.utf8)


do {
    let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

    let user = try decoder.decode(User.self, from: data)
    print("Hi, I'm \(user.firstName) \(user.lastName)")
} catch {
    print("Whoops: \(error.localizedDescription)")
}


