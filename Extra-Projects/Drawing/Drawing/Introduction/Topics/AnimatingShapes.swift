import SwiftUI

struct Trapezoid: Shape { //Every shape protocol has needs a Path or has requirent of Path method, similar to every View needing a body property.
    var insetAmount: CGFloat
    //SwiftUI evaluates our view state before an animation was applied and then again after.
    //If we want to animate a shape changing, we should add an animatableData property
    //AnimatablePair can only animate values that are animatable, which excludes integers.
    var animatableData: CGFloat {/*animatableData property helps interpolates or change the value of insetAmount
in this Trapezoid shape between old value and newvalue being passed to Trapezoid over the length of our 
animation instead of jumping between new values and old values directly. Note: every value which that changes
or interpolates needs to put inside animatableData to enable animation.*/
        get { insetAmount }// returns insetAmount when withAnimation tries to get from animatableData and hence interpolates.
        set { self.insetAmount = newValue }// returns insetAmount when we set it.
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
    }
}

struct AnimatingShapes: View {
    @State private var insetAmount: CGFloat = 50

    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 200)
            .onTapGesture {
                withAnimation {/*SwiftUI uses Core Animation for rendering by default.
This is the same rendering system used by Apple's original iOS framework, UIKit.*/
                    self.insetAmount = CGFloat.random(in: 10...90)
                }
        }
        .navigationBarTitle("Animating simple shapes with animatableData", displayMode: .inline)
    }
}

struct AnimatingShapes_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingShapes()
    }
}
