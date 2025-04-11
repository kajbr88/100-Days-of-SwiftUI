// Alignment and alignment guides – Layout and Geometry SwiftUI Tutorial 2/8

// import SwiftUI

// struct ContentView: View {
//     var body: some View {
//         VStack(alignment: .leading) {
//             ForEach(0..<10) { position in
//                 Text("Number \(position)")
//                     .alignmentGuide(.leading) { _ in Double(position) * -10 }
//             }
//         }
//         .background(.red)
//         .frame(width: 340, height: 400)
//         .background(.blue)
//     }
// }

// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }




// How to create a custom alignment guide – Layout and Geometry SwiftUI Tutorial 3/8

// import SwiftUI

// extension VerticalAlignment {
//     struct MidAccountAndName: AlignmentID {
//         static func defaultValue(in context: ViewDimensions) -> CGFloat {
//             context[.top]
//         }
//     }

//     static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)//constant that wraps the inner VerticalAlignment object for easier access. 
// }

// struct ContentView: View {
//     var body: some View {
//         HStack(alignment: .midAccountAndName) {
//     VStack {
//         Text("@twostraws")
//             .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//         Image("example")
//             .resizable()
//             .frame(width: 64, height: 64)
//     }

//     VStack {
//         Text("Full name:")
//         Text("PAUL HUDSON")
//             .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//             .font(.largeTitle)
//     }
// }
//     }
// }

// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }






// Absolute positioning for SwiftUI views – Layout and Geometry SwiftUI Tutorial 4/8

// import SwiftUI

// struct ContentView: View {
//     var body: some View {
//         Text("Hello, world!")
//                 .background(.red)
//             .position(x: 100, y: 100)
//     }
// }

// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }






// Resizing images to fit the screen using GeometryReader – Layout and Geometry SwiftUI Tutorial 5/8

// import SwiftUI

// struct ContentView: View {
//     var body: some View {
//         HStack {
//             Text("IMPORTANT")
//                 .frame(width: 200)
//                 .background(.blue)

//             GeometryReader { proxy in
//                 Image("example")
//                     .resizable()
//                     .scaledToFit()
//                     .frame(width: proxy.size.width * 0.8)
//                     .frame(width: proxy.size.width, height: proxy.size.height)
//             }
//         }
//     }
// }

// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }







// Understanding frames and coordinates in GeometryReader – Layout and Geometry SwiftUI Tutorial 6/8

// import SwiftUI

// struct OuterView: View {
//     var body: some View {
//         VStack {
//             Text("Top")
//             InnerView()
//                 .background(.green)
//             Text("Bottom")
//         }
//     }
// }

// struct InnerView: View {
//     var body: some View {
//         HStack {
//             Text("Left")
//             GeometryReader { proxy in
//                 Text("Center")
//                     .background(.blue)
//                     .onTapGesture {
//                         print("Global center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
//                         print("Custom center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
//                         print("Local center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
//                     }
//             }
//             .background(.orange)
//             Text("Right")
//         }
//     }
// }

// struct ContentView: View {
//     var body: some View {
//         OuterView()
//             .background(.red)
//             .coordinateSpace(name: "Custom")
//     }
// }

// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }






// ScrollView effects using GeometryReader – Layout and Geometry SwiftUI Tutorial 7/8

// import SwiftUI

// struct ContentView: View {
//     let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

//     var body: some View {
//         ScrollView {
//             ForEach(0..<50) { index in
//                 GeometryReader { proxy in
//                     Text("Row #\(index)")
//                         .font(.title)
//                         .frame(maxWidth: .infinity)
//                         .background(colors[index % 7])
//                         .rotation3DEffect(.degrees(proxy.frame(in: .global).minY / 5), axis: (x: 0, y: 1, z: 0))
//                 }
//                 .frame(height: 40)
//             }
//         }
//     }
// }

// struct ContentView: View {
//     let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

//     var body: some View {
//         GeometryReader { fullView in
//             ScrollView {
//                 ForEach(0..<50) { index in
//                     GeometryReader { proxy in
//                         Text("Row #\(index)")
//                             .font(.title)
//                             .frame(maxWidth: .infinity)
//                             .background(colors[index % 7])
//                             .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
//                     }
//                     .frame(height: 40)
//                 }
//             }
//         }
//     }
// }

// struct ContentView: View {   
//     var body: some View {
//         ScrollView(.horizontal, showsIndicators: false) {
//             HStack(spacing: 0) {
//                 ForEach(1..<20) { num in
//                     GeometryReader { proxy in
//                         Text("Number \(num)")
//                             .font(.largeTitle)
//                             .padding()
//                             .background(.red)
//                             .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
//                             .frame(width: 200, height: 200)
//                     }
//                     .frame(width: 200, height: 200)
//                 }
//             }
//         }
//     }
// }

// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }






// ScrollView effects using visualEffect() and scrollTargetBehavior() – Layout and Geometry SwiftUI 8/8

// import SwiftUI

// struct ContentView: View {   
//     var body: some View {
//         ScrollView(.horizontal, showsIndicators: false) {//creates a horizontal scrolling view without scroll indicators.
//             HStack(spacing: 0) {//arranges the content horizontally with no spacing between elements.
//                 ForEach(1..<20) { number in// iterates through a range of numbers from 1 to 19, creating a view for each number.
//                     Text("Number \(number)")// Displays the current number
//                         .font(.largeTitle)
//                         .padding()
//                         .background(.red)
//                         .frame(width: 200, height: 200)//Sets the size of each view.
//                         .visualEffect {// This modifier allows you to apply custom effects to the content of a view.
//                             content,//content: Represents the original content of the view (in this case, the Text view).
//                              proxy in //proxy: Provides access to the size and position of the content within the view hierarchy.
//                             content //Represents the original content of the view (in this case, the Text view).
//                                 .rotation3DEffect(//Applies a 3D rotation effect to the content
//                                     .degrees(-proxy.frame(in: .global).minX / 8),//Calculates the rotation angle based on the x-coordinate (minX) of the content's leading edge in the global coordinate system. The negative sign inverts the rotation direction.
//                                     axis: (x: 0, y: 1, z: 0)//Specifies the axis of rotation around the y-axis.
//                                 )
//                         }
//                 }
//             }
//             .scrollTargetLayout()
//         }
//         .scrollTargetBehavior(.viewAligned)
//     }
// }

// struct ContentView_Previews: PreviewProvider {
//     static var previews: some View {
//         ContentView()
//     }
// }






import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    let fadeOutDistance: CGFloat = 200
    let minScale: CGFloat = 0.5

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        let offsetY = proxy.frame(in: .global).minY
                        let normalizedOffset = max(0, min(1, 1 - (offsetY - fadeOutDistance) / fullView.size.height))
                        let opacity = Double(normalizedOffset)
                        let scale = max(minScale, 1 - normalizedOffset * (1 - minScale))
                        
                        let hue = min(Double(normalizedOffset) * 0.6, 1.0)
                        let saturation: Double = 0.8
                        let brightness: Double = 0.8
                        let color = Color(hue: hue, saturation: saturation, brightness: brightness)
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(color)
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(opacity)
                            .scaleEffect(scale)
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
