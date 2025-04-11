import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)//x is 0 in all the cases. 
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @StateObject private var vm = FileManagerViewModel()
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {// Our stack of cards will be placed inside a ZStack so we can make them partially overlap with a neat 3D effect.
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {/*Around that ZStack will be a VStack. Right now that VStack won’t do much, but later on it will allow us to place a timer above our cards.*/
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack { //Around that VStack will be another ZStack, so we can place our cards and timer on top of a background.
                    ForEach(Array(vm.cards)) { card in
                        let index = vm.cards.firstIndex(of: card)!
                        
                        CardView(card: vm.cards[index]) { reinsert in
                            withAnimation {
                                removeCard(at: index, reinsert: reinsert)
                            }
                        }
                        .stacked(at: index, in: vm.cards.count)
                        .allowsHitTesting(index == vm.cards.count - 1)
                        .accessibilityHidden(index < vm.cards.count - 1)//enables hit testing when timeRemaining is 1 or greater, but sets it to false otherwise because the user is out of time.
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if vm.cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .backgroundStyle(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer() // to push the plus.circle Button to the right.
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer() // to push the plus.circle Button at the top.
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: vm.cards.count - 1, reinsert: true)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: vm.cards.count - 1, reinsert: false)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")

                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newValue in
            if newValue == .active {
                if vm.cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards(vm: vm)
        }
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int, reinsert: Bool) {
        guard index >= 0 && index < vm.cards.count else { return }
        
        let removedCard = vm.cards.remove(at: index)
        if reinsert == true{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                vm.cards.insert(removedCard, at: 0)
            }
            
            if vm.cards.isEmpty  {
                isActive = false
            }
        }
    }
//    func removeCard(at index: Int, reinsert: Bool) {//dosent work properly
//        guard index >= 0 && index < vm.cards.count else { return }
//
//        let removedCard = vm.cards.remove(at: index)
//        if !reinsert {
//            vm.unmatchedCards.append(removedCard)
//        }
//
//        if index == vm.cards.count - 1 && !vm.unmatchedCards.isEmpty {
//            vm.cards.append(contentsOf: vm.unmatchedCards)
//            vm.unmatchedCards.removeAll()
//        }
//
//        if vm.cards.isEmpty && vm.unmatchedCards.isEmpty {
//            isActive = false
//        }
//    }

    func resetCards() {
        timeRemaining = 100
        isActive = true
        vm.loadData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
