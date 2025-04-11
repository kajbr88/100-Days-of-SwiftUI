import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    //    @State private var alertTitle = "" // all three var required when using Button to calculate.
    //    @State private var alertMessage = ""
    //    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Challenge 1
                Section(header: Text("When do you want to wake up?").font(.headline)) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .font(.title3)
                        .labelsHidden()
                    // .datePickerStyle(WheelDatePickerStyle())
                }
                
                // Challenge 1
                Section(header: Text("Desired amount of sleep").font(.headline)) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours").font(.title3)
                    }
                }
                
                // Challenge 1
                Section(header: Text("Daily coffee intake").font(.headline)) {
                    // Challenge 2 (working but stepper takes less space and is more responsive)
                    Picker("Coffee intake", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) { i in
                            Text("\(i) \(i == 1 ? "cup" : "cups")")
                        }
                    }.font(.title3)
                    .id("coffee")
                    .labelsHidden()
                    
                    // Simplified Stepper
//                    Stepper(value: $coffeeAmount, in: 1...20) {
                    // coffeeAmount == 1 ? Text("1 cup").font(.title3) : Text("\(coffeeAmount) cups").font(.title3)
                    // }
                    
                    // Original Stepper
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20).font(.title3)
                }
                
                // Challenge 3
                Section(header: Text("Recommended bed time").font(.headline)) {
                    Text("\(calculatedBedTime)")
                        .font(.title)
                }
            }
            .navigationBarTitle("BetterRest")
            //            .toolbar {                                 // Original using Calculate button
            //                Button("Calculate", action: calculateBedtime)
            //            }
            
            //            .alert(alertTitle, isPresented: $showingAlert) {   // Original alert message
            //                Button("OK") { }
            //            } message: {
            //                Text("\(alertMessage)")
            //            }
            
            //            .alert(isPresented: $showingAlert) {                 // improved alert message
            //                Alert(title: Text(alertTitle),
            //                      message: Text(alertMessage),
            //                      dismissButton: .default(Text("OK")) { })
        }
    }
    
    // Challenge 3
    var calculatedBedTime: String {
        var message: String
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            var message: String
            do {
                let prediction =  try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
                let sleepTime = wakeUp - prediction.actualSleep // selected wakeUp time - predicted actual sleeps needed in seconds.
                
                message = sleepTime.formatted(date: .omitted, time: .shortened)
            }
            catch {
                message = "Sorry, there was a problem calculating your bedtime."
            }
            return message
        }
        catch {
            message = "Sorry, there was a problem calculating your bedtime."
        }
        return message
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
