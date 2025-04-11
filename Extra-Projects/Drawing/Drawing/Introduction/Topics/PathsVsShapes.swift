import SwiftUI

struct Triangle: Shape {/*Shapes must be able to create a path.
This is the only requirement of the Shape protocol: to be able to create a path in a rectangle.*/
    func path(in rect: CGRect) -> Path {//Paths are not shapes; they are different things.
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        
        let rotationAdjustment = Angle.degrees(90)/* This line introduces a rotation adjustment of 90 degrees.
This is because SwiftUI's coordinate system for arcs differs slightly from the standard mathematical convention.*/
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2,
             startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
/*The drawing direction (inverted here for the coordinate system adjustment). As SwiftUI's coordinate system 
draws direction inverted. */

        return path
    }
}

struct PathsVsShapes: View {
    var body: some View {
        ZStack {
            Triangle()
                .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)

            Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: 300, height: 300)
        }
        .navigationBarTitle("Paths vs shapes", displayMode: .inline)
    }
}

struct PathsVsShapes_Previews: PreviewProvider {
    static var previews: some View {
        PathsVsShapes()
    }
}
