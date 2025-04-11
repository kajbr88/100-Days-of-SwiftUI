import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    var size: String {
        switch resort.size {
        case 1: return "Small"
        case 2: return "Average"
        default: return "Large"
        }
    }
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        Group {/*If we place views inside a Group the parent view decides how those views should be
laid out. This happens because Group is layout neutral.*/
            VStack {/*A VStack can have an alignment or spacing. You can use either, both, or none
             depending on your needs. */
                Text("Size")
                    .font(.caption.bold())
                Text(size)
                    .font(.title3)
            }
            
            VStack {
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: .example)
    }
}
