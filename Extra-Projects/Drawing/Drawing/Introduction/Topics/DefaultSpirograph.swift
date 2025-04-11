import SwiftUI

// algs from https://en.wikipedia.org/wiki/Hypotrochoid
struct Spirograph: Shape {
    var innerRadius: Int // radius of the inner circle
    var outerRadius: Int // radius of the outer circle
    var distance: Int // distance of the virtual pen from the center of the outer circle
    var amount: CGFloat // amount of the roulette to draw. A value between 0 and 1 that controls the portion of the Spirograph curve to be drawn. (at amount value of 1 the two ends meet).

    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)/*incorrect or yields unexpected spirograph as "R" is divided by "r" not inverse, */
        let outerRadius = CGFloat(self.outerRadius)
        let innerRadius = CGFloat(self.innerRadius)
        let distance = CGFloat(self.distance)
        let difference = innerRadius - outerRadius/*incorrect or yields negative difference as "r" is divided by "R" */
        let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount/*endPoint determines the final angle of rotation for both circles in the Spirograph.
This angle directly controls the length of the curve that is generated.*/

        var path = Path()

        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2/*The calculated x and y coordinates are then translated to the center of the drawing area using rect.width / 2 and rect.height / 2*/
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            }
            else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        return path
    }

    /// Greatest Common Divisor
    /// Uses Euclid's algorithm
    func gcd(_ a: Int, _ b: Int) -> Int {/*Calculates the (GCD or HCF) of two integers using Euclid's algorithm.
This is used later to determine the number of loops in the Spirograph.*/
        var a = a
        var b = b

        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }

        return a
    }
}

struct DefaultSpirograph: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount: CGFloat = 1.0
    @State private var hue = 0.6

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                .frame(width: 300, height: 300)

            Spacer()

            Group {
                Text("Inner radius: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Outer radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Amount: \(amount, specifier: "%.2f")")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])

                Text("Color")
                Slider(value: $hue)
                    .padding([.horizontal, .bottom])
                
            }
        }
        .navigationBarTitle("Spirograph", displayMode: .inline)
    }
}

struct DefaultSpirograph_Previews: PreviewProvider {
    static var previews: some View {
        DefaultSpirograph()
    }
}
