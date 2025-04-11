import SwiftUI

struct CardView: View {
    
    let card: Card //let card constant be the current Card its looking at, and also pass it to the Preview.
    var removal: ((Bool) -> Void)? = nil //that’s a closure that accepts no parameters and sends nothing back, defaulting to nil so we don’t need to provide it unless it’s explicitly needed.
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor // checks if color blindness setting is activated.
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero //property to store the drag amount.
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous) //cornerRadius for card
                .fill(
                    differentiateWithoutColor
                   ? .white
                    : .white
                        .opacity(1 - Double(abs(offset.width / 50))) //using 1 minus so that it starts becoming colored straight away.
                ) // card color
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(self.setColor(for: offset.width))
                )
                .shadow(radius: 10) //stacked cards shadow radius value.
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle) //card prompt text font size.
                        .foregroundColor(.black) //card prompt text font color.
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray) //or "(.secondary)" secondary is grey in color.
                    }
                }
            }
            .padding() //padding for cards text
            .multilineTextAlignment(.center) // alignment for text
        }
        .frame(width: 450, height: 250) //dimensions of a card.
        /*offset.width will contain how far the user dragged our card, we don’t use that for rotation because the card would spin too fast,
         So, instead we add this modifier below frame(), we use 1/5th of the drag amount to rotate*/
        .rotationEffect(.degrees(Double(offset.width / 5))) //these three modifiers change the way the views get being rendered.
        .offset(x: offset.width * 2, y: 0)
        .opacity(2 - Double(abs(offset.width / 50))) /*beyond 50 points we start to fade out the card, until at 100 points left or right the opacity is 0.*/
        .accessibilityAddTraits(.isButton)
        .gesture(
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                feedback.prepare()
            }
            .onEnded { _ in
                if abs(offset.width) > 100 {
                    if offset.width < 0 {
                        feedback.notificationOccurred(.error)
                        removal?(true)
                    } else {
                        removal?(false)
                    }
                } else {
                        offset = .zero
                }
            }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
    
    func setColor(for offset: CGFloat) -> Color {
            switch offset {
            case let a where a > 0:
                return .green
            case let b where b < 0:
                return .red
            default:
                return .white
            }
        }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example) /*That will break the preview code because it requires a card
                                 parameter to be passed in, but we already added a static example directly to the Card` struct for this very purpose. */
    }
}
