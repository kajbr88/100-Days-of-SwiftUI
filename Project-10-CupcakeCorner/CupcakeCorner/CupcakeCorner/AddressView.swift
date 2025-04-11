import SwiftUI

struct AddressView: View {
    // @Bindable var order: Order // iOS 17 and above.
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                 NavigationLink("Check out") {
                    CheckoutView(order: order)
                        .onAppear { // Current project Challenge 3
                            let addressItems = [order.name, order.streetAddress, order.city, order.zip]
                            if let encoded = try? JSONEncoder().encode(addressItems) {
                                UserDefaults.standard.set(encoded, forKey: "addressItems")
                                print("Address Items.")
                            }
                        }
                } //NavigationLink
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
} 

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
