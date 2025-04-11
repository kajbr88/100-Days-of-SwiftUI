import SwiftUI

private func color(for value: Int, brightness: Double, steps: Int, amount: Double) -> Color {
    var targetHue = Double(value) / Double(steps) + amount

    if targetHue > 1 {// A color hue of 0.0 is red, and a color hue of 1.0 is also red
        targetHue -= 1
    }

    return Color(hue: targetHue, saturation: 1, brightness: brightness)
}

struct ColorCyclingCircleCoreAnimation: View {
    var amount = 0.0 //to control the color Cycle.
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(color(for: value, brightness: 1, steps: self.steps, amount: self.amount), lineWidth: 2)
            }
        }
    }
}

struct ColorCyclingCircleCoreAnimationSlow: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        color(for: value, brightness: 1, steps: self.steps, amount: self.amount),
                        color(for: value, brightness: 0.5, steps: self.steps, amount: self.amount)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
    }
}

struct ColorCyclingCircleMetal: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        color(for: value, brightness: 1, steps: self.steps, amount: self.amount),
                        color(for: value, brightness: 0.5, steps: self.steps, amount: self.amount)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        //.drawingGroup() enables use of metal to render image offscreen.
        .drawingGroup()
    }
}

struct MetalRendering: View {
    @State private var colorCycle = 0.0
    @State private var selectedView = 0
    let views = ["CA", "CA (slow)", "Metal"]

    var body: some View {
        VStack {

            Picker("Rendering type", selection: $selectedView) {
                ForEach(0..<views.count, id: \.self) { i in
                    Text(self.views[i])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Spacer()

            if selectedView == 0 {
                ColorCyclingCircleCoreAnimation(amount: self.colorCycle)
                    .frame(width: 300, height:  300)
            }
            else if selectedView == 1 {
                ColorCyclingCircleCoreAnimationSlow(amount: self.colorCycle)
                    .frame(width: 300, height:  300)
            }
            else {
                ColorCyclingCircleMetal(amount: self.colorCycle)
                    .frame(width: 300, height:  300)
            }

            Slider(value: $colorCycle)
                .padding()

            Spacer()
        }
        .navigationBarTitle("Enabling high-performance Metal rendering with drawingGroup()", displayMode: .inline)
    }
}

struct MetalRendering_Previews: PreviewProvider {
    static var previews: some View {
        MetalRendering()
    }
}
