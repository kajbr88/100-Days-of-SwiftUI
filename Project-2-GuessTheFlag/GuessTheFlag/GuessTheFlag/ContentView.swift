import SwiftUI

struct FlagImage: View {        // project 3 - challenge 2
    var country: String
    
    init(of country: String) {
        self.country = country
    }
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 5)
    }
}

// shake effect from objc.io https://talk.objc.io/episodes/S01E173-building-a-shake-animation
struct ShakeEffect: GeometryEffect {                                 // project 6 - challenge 3
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
    }

    init(shakes: Int) {
        position = CGFloat(shakes)
    }

    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingScore2 = false
    @State private var scoreTitle = ""
    @State private var scoreTitle2 = ""
    
    @State private var countries = ["Estonia", "France",
                                    "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0            // Challenge 1
    @State private var alertMessage = ""
    @State private var questionCount = 1
    @State private var selectedNumber = 0                   // project 6 - challenge 1
    @State private var fadeOutOpacity = false             // project 6 - challenge 2
    @State private var isCorrect = false                    // project 6 - challenge 1
    @State private var shakeAnimationAmounts = [0, 0, 0]  // project 6 - challenge 3

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                    
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(of: countries[number]) // project 3 - challenge 2
                        } .rotation3DEffect(.degrees(self.isCorrect && self.selectedNumber == number ? 360 : 0), axis: (x: 0.0, y: 1.0, z: 0.0)) // project 6 - challenge 1
                            .opacity(self.fadeOutOpacity && self.selectedNumber != number ? 0.25 : 1) // project 6 - challenge 2
                            .modifier(ShakeEffect(shakes: self.shakeAnimationAmounts[number] * 2))    // project 6 - challenge 3
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Text("Question: \(questionCount)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("\(alertMessage)")
        }
        
        .alert(scoreTitle2, isPresented: $showingScore2) {
            Button("Reset", action: reset)
        } message: {
            Text("\(alertMessage)")
        }
        
    }
    func flagTapped(_ number: Int) {
        self.selectedNumber = number
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            showingScore = true
            alertMessage = ""
            self.isCorrect = true
            self.fadeOutOpacity = true
        } else {
            scoreTitle = "Wrong"
            alertMessage = "Wrong! That’s the flag of \(countries[number])"  // Challenge 2
            showingScore = true
             withAnimation(Animation.easeInOut(duration: flagAnimationDuration)) {
                self.shakeAnimationAmounts[number] = 2
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.showingScore = true
        }
    }
    
    func askQuestion() {  // Challenge 3
        if questionCount == 8 {
            scoreTitle2 = "Game Over"
            alertMessage = "Your score is \(score)"
            showingScore2 = true
        } else {
            questionCount += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            self.isCorrect = false
            self.fadeOutOpacity = false
            self.shakeAnimationAmounts = [0, 0, 0]
        }
    }
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        questionCount = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
