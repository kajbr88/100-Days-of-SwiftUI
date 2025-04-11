import SwiftUI

struct RectangleDivider: View {      // Challenge 2
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

struct RectangleDivider_Previews: PreviewProvider {
    static var previews: some View {
        RectangleDivider()
    }
}
