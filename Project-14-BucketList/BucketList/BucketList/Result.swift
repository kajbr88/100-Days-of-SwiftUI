import Foundation
//here We represent the JSON data using three linked structs.
struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]// pages is a dictionary with Int as page ID and Page as the values.
}

struct Page: Codable, Comparable { /* When a type conforms to the Comparable protocol, it means 
you can use comparison operators like <, >, <=, and >= with instances of that type.*/
    let pageid: Int
    let title: String
    let terms: [String: [String]]?/* terms is a optional dictionary with String as key and array of String as values. */

    var description: String {
    terms?["description"]?.first ?? "No further information"
}

static func <(lhs: Page, rhs: Page) -> Bool { /*When you implement the < operator for your custom type
the  built-in sorted() method can be used to sort arrays of Comparable types.*/
    lhs.title < rhs.title
}
}
