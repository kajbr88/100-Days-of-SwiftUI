import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0 //binded to slider to control the color Cycle.
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        color(for: value, brightness: 1),
                        color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        
        .drawingGroup()/* enables metal rendering to render image offscreen for improved performance. 
        drawingGroup() should only be use when its required when performance or rendering is slow.*/
    }
    
     func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Challenge3: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: self.colorCycle)
                .frame(width: 300, height:  300)

            Slider(value: $colorCycle)
                .padding()

            Spacer()
        }
        .navigationBarTitle("Challenge 3-ColorCyclingRectangle", displayMode: .inline)
    }
}

struct Challenge3_Previews: PreviewProvider {
    static var previews: some View {
        Challenge3()
    }
}
