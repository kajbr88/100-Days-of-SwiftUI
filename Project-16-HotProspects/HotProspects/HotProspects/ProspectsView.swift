import SwiftUI
import SwiftData
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    
    @Query(sort: \Prospect.name) var prospects: [Prospect] //to perform a query for Prospect objects.
    @Environment(\.modelContext) var modelContext // to access the model context that was just created for us.
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()//The () is used to initialize an empty set of Prospect objects.
    @State private var showingSortOptions = false // ✅ Current Project Challenge 3
    @State private var sortByName = true // ✅ Current Project Challenge 3

    enum FilterType {
        case none, contacted, uncontacted
    }

    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }

     var sortedProspects: [Prospect] { // ✅ Current Project Challenge 3
        if sortByName {
            return prospects.sorted(by: { $0.name < $1.name })
       } else {
           return prospects.sorted(by: { $0.dateAdded > $1.dateAdded})
      }
    }
    
    
    var body: some View {
        NavigationStack {
        List(sortedProspects, selection: $selectedProspects) { prospect in // ✅ Current Project Challenge 3

            NavigationLink(destination: EditView(item: prospect)) { // ✅ Current Project Challenge 2
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)

                    if filter == .none{ // ✅ Current Project Challenge 1
                        Image(
                            systemName: (prospect.isContacted == true
                                ? "person.crop.circle.badge.xmark" : "person.crop.circle.fill.badge.checkmark"
                            )
                        )
                        .foregroundStyle((prospect.isContacted == true ? .green : .gray))
                    }
                }
            }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) { /*.destructive sets the color of systemImage to red.*/
                        modelContext.delete(prospect)
                    }
                    
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)

                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)//call addNotification and pass whatever prospect is swiped on.
                    }
                        .tint(.orange)
                    }
                }
                .tag(prospect)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }

                ToolbarItem(placement: .topBarTrailing){ // ✅ Current Project Challenge 3
                    Button("Sort", systemImage: "list.bullet.indent"){
                        showingSortOptions = true
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selected", action: delete)
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
              }
            .confirmationDialog("Sort by", isPresented: $showingSortOptions) { // ✅ Current Project Challenge 3
                Button("Name") {
                    sortByName = true
                }
                Button("Most Recent") {
                    sortByName = false
                }
            }
        }
    }
    
    init(filter: FilterType) {
        self.filter = filter
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {/* "_"assigns a new Query instance to the 
underlying property wrapper storage (_prospects).*/
            $0.isContacted == showContactedOnly/*This defines a predicate (filter condition)
for the query. It uses a closure (anonymous function) to specify that the query should only
return Prospect objects where the isContacted property matches the value of showContactedOnly.*/
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        let currentDate = Date() // ✅ Current Project Challenge 3
        isShowingScanner = false
        switch result {
        case .success(let result)://if result is successfull provide the resulting data inside that.
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false, dateAdded: currentDate) // ✅ Current Project Challenge 3
            
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()/* This line retrieves a reference to
the current UNUserNotificationCenter instance. This center serves as the control point for 
managing local notifications in the app.*/
        
        let addRequest = {//This creates a closure that encapsulates the logic for creating and adding a notification request.
            let content = UNMutableNotificationContent()//Creates an instance of UNMutableNotificationContent to define the notification's content.
            content.title = "Contact \(prospect.name)"//Sets the notification title.
            content.subtitle = prospect.emailAddress//Sets the notification subtitle.
            content.sound = UNNotificationSound.default// Sets the notification sound to the default system sound.
            
//comment: Below commented code could be used to schedule a notification for a specific time of day.
            // var dateComponents = DateComponents()//dateComponents would be configured with the desired hour, minute, etc.
            // dateComponents.hour = 9
//comment: UNCalendarNotificationTrigger would be used with these dateComponents to trigger the notification at that specific time.            
            // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)//assigning false to repeats dosent trigger the notification every day
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)//This test trigger instance fires the notification after a specified time interval (5 seconds in this case) and doesn't repeat.
            
/*comment: Below line of code Creates a UNNotificationRequest object that combines the notification content and trigger.
UUID().uuidString generates a unique identifier for this notification request.*/            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)//This line attempts to add the created notification request to the notification center.
        }
        
        //Requesting Authorization (if needed):
        center.getNotificationSettings { settings in//Retrieves the current notification settings using the getNotificationSettings method.
            if settings.authorizationStatus == .authorized {//Checks if the app is already authorized to display notifications.
                addRequest()//The addRequest closure is called, scheduling the notification.
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in //Requests permission from the user to display alerts, badges, and sounds for notifications.
                    if success {
                        addRequest()//The addRequest closure is called, scheduling the notification.
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
        ProspectsView(filter: .none)
            .modelContainer(for: Prospect.self)
}
