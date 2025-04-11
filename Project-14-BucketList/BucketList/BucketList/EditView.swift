import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    @State private var viewModel: ViewModel // Current Project Challlenge 3
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = State(initialValue: ViewModel(location: location))
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces() // Current Project Challlenge 3
            }
        }
    }
}

#Preview {
    EditView(location: .example) { _ in }
}

// use the following init in case of non MVVM
//     init(location: Location, onSave: @escaping (Location) -> Void) {
//         self.location = location
//         self.onSave = onSave

//         _name = State(initialValue: location.name) /* These are private properties (indicated by the leading
// underscore _). State(initialValue:) is a initializer for the State property wrapper, It creates a state
// object that holds a value and triggers a UI update whenever that value changes. */
//         _description = State(initialValue: location.description)
//     }
