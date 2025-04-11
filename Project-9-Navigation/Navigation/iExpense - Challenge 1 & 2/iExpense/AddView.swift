import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var title = "Add new expense"
    var expenses: Expenses
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline) // Project 9 - Navigation - Challenge 2
            .navigationBarBackButtonHidden() // Project 9 - Navigation - Challenge 2
              .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    if(item.type == "Personal") { // Challenge 3
                        expenses.itemsPersonal.append(item)
                    } else {
                        expenses.itemsBusiness.append(item)
                    }
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
