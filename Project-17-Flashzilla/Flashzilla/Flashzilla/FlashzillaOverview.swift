// How to use gestures in SwiftUI – Flashzilla SwiftUI Tutorial 1/13

import SwiftUI

//  struct FlashzillaOverview: View {
//     var body: some View {
//         Text("Hello World!")
//             .onTapGesture(count: 2) {
//                 print("Double tapped!")
//             }
//
//         Text("Hello, World!")
//             .onLongPressGesture(minimumDuration: 2) { //completion closure
//                 print("Long pressed!")
//             } onPressingChanged: { inProgress in //change closure
//                 print("In progress: \(inProgress)!")
//             }
//     }
// }

// struct FlashzillaOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         FlashzillaOverview()
//     }
// }

// How to use gestures in SwiftUI – Flashzilla SwiftUI Tutorial 1.1/13

//   struct FlashzillaOverview: View {
//      @State private var currentAmount = 0.0/* this is going to store how much we're going to 
//  scale up and down in the current gesture */
//      @State private var finalAmount = 1.0/*Current finished scaling value for the particular view*/

//      var body: some View {
//          Text("Hello, World!")
//              .scaleEffect(finalAmount + currentAmount)//This modifier scales the text view.
//              .gesture(
//                  MagnifyGesture()
//                      .onChanged { value in /* MagnifyGesture() has onChanged closure with 
//  current magnification value being passed in in the "value".*/
//                          currentAmount = value.magnification - 1 /*value.magnification will be
//              1 by default because it hasn't zoomed up at all fyi(lower than 1 means its shrinking
//  higher than one means its streched bigger)*/
//                      }
//                      .onEnded { value in
//                          finalAmount += currentAmount 
//                          currentAmount = 0
//                      }
//              )
//      }
//  }


// struct FlashzillaOverview: View {
//     @State private var currentAmount = Angle.zero
//     @State private var finalAmount = Angle.zero

//     var body: some View {
//         Text("Hello, World!")
//             .rotationEffect(currentAmount + finalAmount)
//             .gesture(
//                 RotateGesture()  
//                     .onChanged { value in
//                         currentAmount = value.rotation
//                     }
//                     .onEnded { value in
//                         finalAmount += currentAmount
//                         currentAmount = .zero
//                     }
//             )
//     }
// }


// struct FlashzillaOverview: View {
//     var body: some View {
//         VStack {
//             Text("Hello, World!")/* SwiftUI will always give the child’s gesture priority,
//  which means when you tap the text view above you’ll see “Text tapped”.*/
//                 .onTapGesture {
//                     print("Text tapped")
//                 }
//         }
//         .onTapGesture {
//             print("VStack tapped")
//         }
//     }
// }

// struct FlashzillaOverview: View {
// var body: some View {
//        VStack {
//            Text("Hello, World!")
//                .onTapGesture {
//                    print("Text tapped")
//                }
//        }
//        .highPriorityGesture(/* if you want to change that(previous mentioned default behaviour) 
// you can use the highPriorityGesture() modifier to force the parent’s gesture to trigger instead.*/
//            TapGesture()
//                .onEnded {
//                    print("VStack tapped")
//                }
//        )
//    }
// }

// struct FlashzillaOverview: View {
//     var body: some View {
//         VStack {
//             Text("Hello, World!")
//                 .onTapGesture {
//                     print("Text tapped")
//                 }
//         }
//         .simultaneousGesture(/*use the simultaneousGesture() modifier to tell SwiftUI you want
//  both the parent and child gestures to trigger at the same time*/
//             TapGesture()
//                 .onEnded {
//                     print("VStack tapped")
//                 }
//         )
//     }
// }

//struct FlashzillaOverview: View {
//    // how far the circle has been dragged
//    @State private var offset = CGSize.zero
//
//    // whether it is currently being dragged or not
//    @State private var isDragging = false
//
//    var body: some View {
//        // a drag gesture that updates offset and isDragging as it moves around
//        let dragGesture = DragGesture()
//            .onChanged { value in offset = value.translation }
//            .onEnded { _ in
//                withAnimation {
//                    offset = .zero
//                    isDragging = false
//                }
//            }
//
//        // a long press gesture that enables isDragging
//        let pressGesture = LongPressGesture()
//            .onEnded { value in
//                withAnimation {
//                    isDragging = true
//                }
//            }
//
//        // a combined gesture that forces the user to long press then drag
//        let combined = pressGesture.sequenced(before: dragGesture)
//
///*a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back
//from the drag gesture, and uses our combined gesture */
//        Circle()
//            .fill(.red)
//            .frame(width: 64, height: 64)
//            .scaleEffect(isDragging ? 1.5 : 1)
//            .offset(offset)
//            .gesture(combined)
//    }
//}

// struct FlashzillaOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         FlashzillaOverview()
//     }
// }






// Disabling user interactivity with allowsHitTesting(): – Flashzilla SwiftUI Tutorial 2/13

 struct FlashzillaOverview: View {
     var body: some View {
         ZStack {
             Rectangle()
                 .fill(.blue)
                 .frame(width: 300, height: 300)
                 .onTapGesture {
                     print("Rectangle tapped!")
                 }

             Circle()
                 .fill(.red)
                 .frame(width: 300, height: 300)
//                 .contentShape(.rect)
                 .onTapGesture {
                     print("Circle tapped!")
                 }
                  .allowsHitTesting(false)//setting it to false, the view isn’t considered tappable.
         }
     }
 }


// struct FlashzillaOverview: View {
//     var body: some View {
//         VStack {
//             Text("Hello")
//             Spacer().frame(height: 100)
//             Text("World")
//         }
//         .contentShape(.rect)
//         .onTapGesture {
//             print("VStack tapped!")
//         }
//     }
// }	

// struct FlashzillaOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         FlashzillaOverview()
//     }
// }






// Triggering events repeatedly using a time – Flashzilla SwiftUI Tutorial 3/13

// struct FlashzillaOverview: View {
//     let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()//The code to create a timer publisher.
    
//     @State private var counter = 0
    
//     var body: some View {
//         Text("Hello, World!")
//             .onReceive(timer) { time in
//                 if counter == 5 {
//                     timer.upstream.connect().cancel()
//                 } else {
//                     print("The time is now \(time)")
//                 }
                
//                 counter += 1
//             }
//     }
// }
    
// struct FlashzillaOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         FlashzillaOverview()
//     }
// }






// How to be notified when your SwiftUI app moves to the background – Flashzilla SwiftUI Tutorial 4/13

// struct FlashzillaOverview: View {
//     @Environment(\.scenePhase) var scenePhase

//     var body: some View {
//         Text("Hello, world!")
//             .onChange(of: scenePhase) { oldPhase, newPhase in
//                 if newPhase == .active {
//                     print("Active")
//                 } else if newPhase == .inactive {
//                     print("Inactive")
//                 } else if newPhase == .background {
//                     print("Background")
//                 }
//             }
//     }
// }

// struct FlashzillaOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         FlashzillaOverview()
//     }
// }






// Supporting specific accessibility needs with SwiftUI – Flashzilla SwiftUI Tutorial 5/13

// struct FlashzillaOverview: View {
//      @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

//     var body: some View {
//         HStack {
//             if differentiateWithoutColor {
//                 Image(systemName: "checkmark.circle")
//             }

//             Text("Success")
//         }
//         .padding()
//         .background(differentiateWithoutColor ? .black : .green)
//         .foregroundStyle(.white)
//        .clipShape(.capsule)
//     }
// }

// struct ContentView: View {
//     @Environment(\.accessibilityReduceMotion) var reduceMotion
//     @State private var scale = 1.0

//     var body: some View {
//         Button("Hello, World!") {
//             if reduceMotion {
//                 scale *= 1.5
//             } else {
//                 withAnimation {
//                     scale *= 1.5
//                 }
//             }

//         }
//         .scaleEffect(scale)
//     }
// }

// *********************** OR **************************

//func withOptionalAnimation<Result>(_ animation: Animation? = .default,//The <Result> part indicates that the function can work with any type of result.
//     _ body: () throws -> Result) rethrows -> Result { //This closure ( scale *= 1.5) is passed to the withOptionalAnimation function as the body parameter.
//    if UIAccessibility.isReduceMotionEnabled {
//        return try body() //If "Reduce Motion" is enabled, return try body() executes the provided closure (in this case, scale *= 1.5).
//    } else {
//        return try withAnimation(animation, body)//If "Reduce Motion" is disabled, the provided closure "scale *= 1.5" is executed within the withAnimation function with the passed animation or the default animation if no animation was passed to the withOptionalAnimation function.
//    }
//}
//
//struct FlashzillaOverview: View {
//    @Environment(\.accessibilityReduceMotion) var reduceMotion
//    @State private var scale = 1.0
//
//    var body: some View { //body a View Builder porperty is used to define the user interface of the view.The body property is a computed property that returns a value conforming to the View protocol.
//        Button("Hello, World!") {
//            withOptionalAnimation {
//            // withOptionalAnimation(Animation.spring(response: 0.3, dampingFraction: 0.5)) { // spring animation passed to withOptionalAnimation.
//                scale *= 1.5
//            }
//        }
//        .scaleEffect(scale)
//    }
//}

// struct FlashzillaOverview: View {
//     @Environment(\.accessibilityReduceTransparency) var reduceTransparency

//     var body: some View { 
//         Text("Hello, World!")
//             .padding()
//             .background(reduceTransparency ? .black : .black.opacity(0.5))
//             .foregroundStyle(.white)
// //            .clipShape(.capsule)
//     }
// }

struct FlashzillaOverview_Previews: PreviewProvider {
    static var previews: some View {
        FlashzillaOverview()
    }
}
