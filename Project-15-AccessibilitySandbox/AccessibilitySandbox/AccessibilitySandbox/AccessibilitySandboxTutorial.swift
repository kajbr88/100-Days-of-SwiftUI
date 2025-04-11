// Identifying views with useful labels – Accessibility SwiftUI Tutorial 1/7

// import SwiftUI

// struct AccessibilitySandboxTutorial: View {
//     let pictures = [
//         "ales-krivec-15949",
//         "galina-n-189483",
//         "kevin-horstmann-141705",
//         "nicolas-tissot-335096"
//     ]

//     let labels = [
//         "Tulips",
//         "Frozen tree buds",
//         "Sunflowers",
//         "Fireworks",
//     ]

//     @State private var selectedPicture = Int.random(in: 0...3)

//     var body: some View {
//         Button {
//             selectedPicture = Int.random(in: 0...3)
//         } label: {
//             Image(pictures[selectedPicture])
//                 .resizable()
//                 .scaledToFit()
//         }
//         .accessibilityLabel(labels[selectedPicture])
//     }
// }

// struct AccessibilitySandboxTutorial_Previews: PreviewProvider {
//     static var previews: some View {
//         AccessibilitySandboxTutorial()
//     }
// }





// Hiding and grouping accessibility data – Accessibility SwiftUI Tutorial 2/7

//import SwiftUI
//
//struct AccessibilitySandboxTutorial: View {
//
//    var body: some View {
//        //       Image(decorative: "character") //  tells SwiftUI it should be ignored by VoiceOver.
//
//        //       Image(.character)
//        //    .accessibilityHidden(true)//makes any view completely invisible to the accessibility system.
//
//        VStack {
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }
//        // .accessibilityElement(children: .combine)//this will cause both text views to be read together, with a short pause between them.
//        .accessibilityElement(children: .ignore)//Using .ignore and a custom label means "as defined in the modifier below" the text is read all at once, and is much more natural. also using .ignore completely ignores any child elements.
// .ignore is the default parameter for children, so you can get the same results as .accessibilityElement(children: .ignore) just by saying .accessibilityElement().
//        .accessibilityLabel("Your score is 1000")//custom label
//    }
//}
//
//struct AccessibilitySandboxTutorial_Previews: PreviewProvider {
//    static var previews: some View {
//        AccessibilitySandboxTutorial()
//    }
//}





// Reading the value of controls – Accessibility SwiftUI Tutorial 3/7

// import SwiftUI

// struct AccessibilitySandboxTutorial: View {

//     @State private var value = 10

//     var body: some View {
//         VStack {
//             Text("Value: \(value)")

//             Button("Increment") {
//                 value += 1
//             }

//             Button("Decrement") {
//                 value -= 1
//             }
//         }
//         .accessibilityElement()
//         .accessibilityLabel("Value")
//         .accessibilityValue(String(value))
//         .accessibilityAdjustableAction { direction    in
//             switch direction {
//             case .increment:
//                 value += 1
//             case .decrement:
//                 value -= 1
//             default:
//                 print("Not handled.")
//             }
//         }
//     }
// }

// struct AccessibilitySandboxTutorial_Previews: PreviewProvider {
//     static var previews: some View {
//         AccessibilitySandboxTutorial()
//     }
// }






// Handling voice input in SwiftUI – Accessibility SwiftUI Tutorial 4/7

import SwiftUI

struct AccessibilitySandboxTutorial: View {
    
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button tapped")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
    }
}

struct AccessibilitySandboxTutorial_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilitySandboxTutorial()
    }
}






// Fixing Guess the Flag – Accessibility SwiftUI Tutorial 5/7

// Updated Guess the Flag project available in the AccessibilitySandbox folder.
