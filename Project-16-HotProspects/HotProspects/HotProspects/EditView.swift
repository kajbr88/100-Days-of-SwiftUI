import SwiftUI
import SwiftData

struct EditView: View { // ✅ Current Project Challenge 2
    @Bindable var item: Prospect
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Name", text: $item.name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Email", text: $item.emailAddress)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()

            }
            .navigationTitle("Edit")
        }
    }
}
