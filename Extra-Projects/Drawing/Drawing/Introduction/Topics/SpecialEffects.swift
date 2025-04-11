import SwiftUI

struct MultiplyBlend: View {
    var body: some View {
        ZStack {
            // Photo by Olivia Hutcherson on Unsplash https://unsplash.com/photos/JtVkmKQ1FQI
            Image("olivia-hutcherson-JtVkmKQ1FQI-unsplash")
                .resizable()
                .aspectRatio(contentMode: .fit)

            Rectangle()
                .fill(Color.red)
                .blendMode(.multiply)
        }
        .frame(width: 400, height: 500)
        .clipped()
    }
}

struct Circles: View {
    @State private var amount: CGFloat = 0.75 //binded to slider

    var body: some View {
        VStack {
            ZStack {
                Circle()/*SwiftUI's Color.red is not a pure red color.
It's actually a custom color blend that looks better in light and dark mode. below used method produces real colors*/
                    .fill(Color(red: 1, green: 0, blue: 0))//Color is a view, but not a shape.
                    .frame(width: 200 * amount) // circle gets bigger or smaller depending on how much we move our slider around.
                    .offset(x: -50, y: -80) // adding offset so it moves to one side of the screen(top left).
                    .blendMode(.screen)

                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))//real green
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80) //move to the right
                    .blendMode(.screen)

                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))//real blue
                    .frame(width: 200 * amount) //no offset so it will stay centered.
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)

            Slider(value: $amount)/*having the slider at 0 means the image is blurred and colorless, but as you move the slider to the right it gains color and becomes sharp.*/
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlurSaturation: View {
    @State private var amount: CGFloat = 0.75

    var body: some View {
        VStack {
            // Photo by Olivia Hutcherson on Unsplash https://unsplash.com/photos/JtVkmKQ1FQI
            Image("olivia-hutcherson-JtVkmKQ1FQI-unsplash")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(Double(amount))
                .blur(radius: (1 - amount) * 10)//We can use blur() on any view.

            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SpecialEffects: View {
    @State private var selectedView = 0
    let views = ["Multiply", "Screen", "BlurSaturation"]

    var body: some View {
        VStack {
            Picker("Effect", selection: $selectedView) {
                ForEach(0..<views.count, id: \.self) { i in
                    Text(self.views[i])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Spacer()

            if selectedView == 0 {
                MultiplyBlend()
            }
            else if selectedView == 1 {
                Circles()
            }
            else {
                BlurSaturation()
            }
        }
        .navigationBarTitle("Special effects in SwiftUI: blurs, blending & more", displayMode: .inline)
    }
}

struct SpecialEffects_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffects()
    }
}
