import Foundation
import CoreData


extension Country {
    //The @nonobjc attribute in Swift tells the compiler to not generate Objective-C selectors for the method it precedes.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {/*This class method returns an NSFetchRequest object, which is used to fetch instances of the Country entity from the persistent store.*/
        return NSFetchRequest<Country>(entityName: "Country")
    }
    
    @NSManaged public var fullName: String?/*removing optional "?" for @NSManaged variables dosent make them 
    unoptional as @NSManaged wrapped variables are old Obj-C type and still are optional implicitly hence,
     convenience wrappers need to be added */ 
    @NSManaged public var shortName: String?
    @NSManaged public var candy: NSSet?/*NSSet is the older Objective-C data type that is equivalent to Swift’s
 Set, but we can’t use it with SwiftUI’s ForEach. To fix this we need to modify the files Xcode generated for us,
  adding convenience wrappers that make SwiftUI work well. */
    
    public var wrappedShortName: String {//convenience wrapper
        shortName ?? "Unknown Country"
    }
    
    public var wrappedFullName: String {//convenience wrapper
        fullName ?? "Unknown Country"
    }

    //convenience wrapper 
    public var candyArray: [Candy] {//candyArray is a computed variable of type "array of Candy".
    let set = candy as? Set<Candy> ?? [] //as? is a (Conditional Casting):
    return set.sorted {//running .sorted method on a set converts the set to an array.
        $0.wrappedName < $1.wrappedName/* "<" acts as a "comparison function" that the sorted method uses to determine
 the correct order for all elements in the set, not just pairs.*/
    }
}
}

// MARK: Generated accessors for candy
extension Country {
    
    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)
    
    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)
    
    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)
    
    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)
    
}

extension Country : Identifiable {
    
}
