import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
//    @State private var tipPercentage = 20
    @State private var tipPercentageEntry = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: [Double] {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentageEntry)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return [grandTotal, amountPerPerson]
    }
    @FocusState private var amountIsFocused: Bool
    var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currency?.identifier ?? "INR")
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    } 
//					.pickerStyle(.segmented)
                } header: {
                    Text("Cheque")
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentageEntry) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
					.pickerStyle(.navigationLink) // Challenge 3
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson[1], format: currencyFormatter)
                } header: { // Challenge 1
                    Text("Amount per person")
                }
                
                Section { // Challenge 2
                    Text(totalPerPerson[0], format: currencyFormatter)
                        .foregroundColor(tipPercentageEntry == 0 ? .red : .black) // Project 3 - Challenge 1
                } header: {
                    Text("Total Amount (Original Amount + Tip)")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            
        }
    }
}
