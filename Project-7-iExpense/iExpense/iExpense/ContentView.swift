import SwiftUI
import Combine // use this import for iOS 16 and below and remove Observation.
////import Observation // use this import for iOS 17 and obove and remove Combine.

struct ContentView: View {
    @StateObject private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal expenses") {
                    ForEach(expenses.itemsPersonal) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) // challenge 1
                                .modifier(Custom(amount: Int(item.amount))) // challenge 2
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section("Business expenses"){
                    ForEach(expenses.itemsBusiness) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) // challenge 1
                                .modifier(Custom(amount: Int(item.amount))) // challenge 2
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        expenses.itemsPersonal.remove(atOffsets: offsets)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        expenses.itemsBusiness.remove(atOffsets: offsets)
    }
}

struct Custom: ViewModifier { // challenge 2
    let amount: Int
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(getColor())
    }
    
    func getColor() -> Color {
        if(amount < 10) {
            return Color.blue
        } else if(amount < 100) {
            return Color.orange
        } else {
            return Color.red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
