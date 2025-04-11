////Working with two side by side views in SwiftUI – SnowSeeker SwiftUI Tutorial 1/12
//
//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        
//        NavigationSplitView(columnVisibility: .constant(.all)) {
//            NavigationLink("Primary") {
//                Text("New view")
//            }
//        } detail: {
//            Text("Content")
//                .navigationTitle("Content View")
//        }
//        .navigationSplitViewStyle(.balanced)
//    }}
//
//struct SnowSeekerOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        SnowSeekerOverview()
//    }
//}
//
//
//
//
//
//
////Using alert() and sheet() with optionals – SnowSeeker SwiftUI Tutorial 2/12
//
//import SwiftUI
//
//struct User: Identifiable {
//    var id = "Taylor Swift"
//}
//
//struct SnowSeekerOverview: View {
//    @State private var selectedUser: User? = nil
//
//    var body: some View {
//        Button("Tap Me") {
//            selectedUser = User()//on tap of the button assigns selectedUser a new User instance.
//        }
//        .sheet(item: $selectedUser) { user in//displays a sheet when selectedUser has a value. "user" will be the unwrapped User value when it exists.
//            Text(user.id)//its not optional here.
//        }
//    }
//}
//
//struct SnowSeekerOverview: View {
//    @State private var selectedUser: User? = nil
//    @State private var isShowingUser = false
//
//    var body: some View {
//        Button("Tap Me") {
//            selectedUser = User()
//            isShowingUser = true//on tap of the button assigns selectedUser a new User instance.
//        }//presenting is a optional closure that provides the content of the alert body. In this case, it uses the selectedUser value.
//        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in /* This closure Receives the "selectedUser" It takes the selectedUser object as an argument, allowing you to access its properties (like id, name, etc.) within the alert's content.*/
//            Button(user.id)//The button's label is dynamically set to user.id, utilizing the information from the selectedUser.
//              { }// In this specific example, the button's action closure is empty
//        }
//    }
//}
//
//struct SnowSeekerOverview: View {
//    @State private var selectedUser: User? = nil
//
//    var body: some View {
//        Button("Tap Me") {
//            selectedUser = User()//on tap of the button assigns selectedUser a new User instance.
//        }
//        .sheet(item: $selectedUser) { user in
//            Text(user.id)
//                .presentationDetents([.medium, .large])/*presentation detents makes the sheet 
//take up less than the full screen space. Because we're specifying two sizes here, the initial
//size will be used when the sheet is first shown, but iOS will show a little grab handle that 
//lets users pull the sheet up to full size.*/
//        }
//    }
//}
//
//struct SnowSeekerOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        SnowSeekerOverview()
//    }
//}
//
//
//
//
//
//
//
////Swiftful thinking @ViewBuilder
//
//import SwiftUI
//
//struct HeaderViewRegular: View {
//
//   let title: String
//   let description: String?
//   let iconName: String?
//
//   var body: some View {
//       VStack(alignment: .leading) {
//           Text(title)
//               .font(.largeTitle)
//               .fontWeight(.semibold)
//           if let description = description {
//               Text(description)
//                   .font(.callout)
//           }
//           if let iconName = iconName {
//               Image(systemName: iconName)
//           }
//           RoundedRectangle(cornerRadius: 5)
//               .frame(height: 2)
//       }
//       .frame(maxWidth: .infinity, alignment: .leading)
//       .padding()
//   }
//
//}
//
//struct HeaderViewGeneric<Content: View>: View {
//
//   let title: String
//   let content: Content
//
//   init(title: String, @ViewBuilder content: () -> Content) {//declaring @ViewBuilder is optional here since HStack internally has @ViewBuilder defined.
//       self.title = title
//       self.content = content()/*setting up self.content we actually just need to call that
//                                func thats returning us content */
//   }
//
//   var body: some View {
//       VStack(alignment: .leading) {
//           Text(title)
//               .font(.largeTitle)
//               .fontWeight(.semibold)
//
//           content
//
//           RoundedRectangle(cornerRadius: 5)
//               .frame(height: 2)
//       }
//       .frame(maxWidth: .infinity, alignment: .leading)
//       .padding()
//   }
//}
//
//struct CustomHStack<Content:View>:View {
//
//   let content: Content
//
//   init( @ViewBuilder content: () -> Content) {
//       self.content = content()
//   }
//
//   var body: some View {
//       HStack {
//           content
//       }
//   }
//
//}
//
//
//struct SnowSeekerOverview: View {
//   var body: some View {
//       VStack {
//           HeaderViewRegular(title: "New Title", description: "Hello", iconName: "heart.fill")
//
//           HeaderViewRegular(title: "Another title", description: nil, iconName: nil)
//
//           HeaderViewGeneric(title: "Generic Title") {// the closure is the Content
//               HStack{ //HStack has @ViewBuilder attribute internally, hence it dosent need to be defined again when setting argument.
//                   Text("Hi")
//                   Image(systemName: "heart.fill")
//                   Text("hi")
//
//               }
//           }
//
//           CustomHStack {
//               Text("Hi")
//               Text("Hi")
//           }
//
//           HStack {
//               Text("Hi")
//               Text("Hi")
//           }
//
//           LocalViewBuilder(type: .one)
//
//           Spacer()
//       }
//   }
//}
//
//struct SnowSeekerOverview_Previews: PreviewProvider {
//   static var previews: some View {
//       SnowSeekerOverview()
//   }
//}
//
//
//struct LocalViewBuilder: View {//since this struct is a view hence there needs to be a body.
//
//   enum ViewType {
//       case one, two, three
//   }
//   let type: ViewType
//
//   var body: some View {//every view needs to have a body.
//       VStack {
//           headerSection
//       }
//   }
//
//   @ViewBuilder private var headerSection: some View {//by using return AnyView or @ViewBuilder helps the compiler infer a single, consistent return type for your headerSection property adn avoids opaque reutrn type error.
//        switch type {
//        case .one:
//            viewOne
//        case .two:
//            viewTwo
//        case .three:
//            viewThree
//        }
////       if type == .one {
////           viewOne
////       } else if type == .two {
////           viewTwo
////       } else if type == .three {
////           viewThree
////       }
//   }
//
//   private var viewOne: some View {
//       Text("One!")
//   }
//
//   private var viewTwo: some View {
//       VStack {
//           Text("TWOOO")
//           Image(systemName: "heart.fill")
//       }
//   }
//
//   private var viewThree: some View {
//       Image(systemName: "heart.fill")
//   }
//
//}
//
//
//
//
//
//
//// Using groups as transparent layout containers – SnowSeeker SwiftUI Tutorial 3/12
//
//import SwiftUI
//
//struct UserView: View {
//    var body: some View {
//        Group {
//            Text("Name: Paul")
//            Text("Country: England")
//            Text("Pets: Luna and Arya")
//        }
//        .font(.title)
//    }
//}
//
//struct ContentView: View {
//    @State private var layoutVertically = false
//
//    var body: some View {
//        Button {
//            layoutVertically.toggle()
//        } label: { 
//            if layoutVertically {
//                VStack {
//                    UserView()
//                }
//            } else {
//                HStack {
//                    UserView()
//                }
//            }
//        }
//    }
//}
//
//struct SnowSeekerOverview: View {
//    @Environment(\.horizontalSizeClass) var horizontalSizeClass
//
//    var body: some View {
//        if horizontalSizeClass == .compact {
//            VStack(content: UserView.init)
//        } else {
//            HStack(content: UserView.init)
//        }
//    }
//}
//
//struct SnowSeekerOverview: View {
//
//    var body: some View {
//        ViewThatFits {//if this can't fit into the available space it will try other ones and show the one that suceeds. 
////            Rectangle()
////                .frame(width: 500, height: 200)
////
////            Circle()
////                .frame(width: 200, height: 200)
//            HStack(content: UserView.init)
//            VStack(content: UserView.init)
//        }
//    }
//}
//
//struct SnowSeekerOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        SnowSeekerOverview()
//    }
//}
//
//
//
//
//
//
////Making a SwiftUI view searchable – SnowSeeker SwiftUI Tutorial 4/12
//
//import SwiftUI
//
//struct SnowSeekerOverview: View {
//    @State private var searchText = ""
//    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
//
//    var filteredNames: [String] {
//        if searchText.isEmpty {
//            return allNames
//        } else {
//            return allNames.filter { name in
//                 name.localizedStandardContains(searchText)
//            }
//        }
//    }
//
//    var body: some View {
//        NavigationStack {
//            List(filteredNames, id: \.self) { name in
//                Text(name)
//            }
//            .searchable(text: $searchText, prompt: "Look for something")
//            .navigationTitle("Searching")
//        }
//    }
//}
//
//struct SnowSeekerOverview_Previews: PreviewProvider {
//    static var previews: some View {
//        SnowSeekerOverview()
//    }
//}





//Sharing @Observable objects through SwiftUI's environment – SnowSeeker SwiftUI Tutorial 5/12

//import SwiftUI
//
//@Observable
//class Player {
//  var name = "Anonymous"
//  var highScore = 0
//}
//
//struct HighScoreView: View {// HighScoreView is a subview.
//   @Environment(Player.self) var player
//
//  var body: some View {
//       @Bindable var player = player
//
//      Stepper("High score: \(player.highScore)", value: $player.highScore)/* value binding is a value 
//      that the stepper will control.*/
//  }
//}
//
//struct SnowSeekerOverview: View {
//  @State private var player = Player()
//  
//  var body: some View {
//      VStack {
//          Text("Welcome!")
//          HighScoreView()
//      }
//       .environment(player)/*Use the environment() modifier to place our object into the environment.
//        This modifier is designed for classes that use the @Observable macro.*/
//  }
//}
//
//struct SnowSeekerOverview_Previews: PreviewProvider {
//  static var previews: some View {
//      SnowSeekerOverview()
//  }
//}
