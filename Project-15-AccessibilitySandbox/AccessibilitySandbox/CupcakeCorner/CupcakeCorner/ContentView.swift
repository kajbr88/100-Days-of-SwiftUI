import SwiftUI

struct ContentView: View {
//    @State private var order = Order() // iOS 17 and above
    @ObservedObject private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {/* Selection: $order.type binds the picker to the type property of the Order object. 
This means that whenever the user selects an option, the type property will be updated accordingly.*/
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
