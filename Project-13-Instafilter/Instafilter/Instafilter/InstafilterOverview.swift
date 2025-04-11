// How property wrappers become structs – Instafilter SwiftUI Tutorial 2/13

import SwiftUI

// struct InstafilterOverview: View {
//    @State private var blurAmount = 0.0 {
//     didSet {
//         print("New value is \(blurAmount)")
//     }
// }

//     var body: some View {
//         VStack {
//             Text("Hello, World!")
//                 .blur(radius: blurAmount)

//             Slider(value: $blurAmount, in: 0...20)

//             Button("Random Blur") {
//                 blurAmount = Double.random(in: 0...20)
//             }
//         }
//     }
// }

// struct InstafilterOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         InstafilterOverview()
//     }
// }




// Showing multiple options with confirmationDialog() – Instafilter SwiftUI Tutorial 2/13

// import SwiftUI

// struct InstafilterOverview: View {

//     @State private var blurAmount = 0.0

//     var body: some View {
//         VStack {
//             Text("Hello, World!")
//                 .blur(radius: blurAmount)

//             Slider(value: $blurAmount, in: 0...20)
//                 .onChange(of: blurAmount) {  newValue in
//                     print("New value is \(newValue)")
//                 }
//         }
//     }
// }

// struct InstafilterOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         InstafilterOverview()
//     }
// }




// Showing multiple options with confirmationDialog() – Instafilter SwiftUI Tutorial 3/13

// struct InstafilterOverview: View {
//     @State private var showingConfirmation = false
//     @State private var backgroundColor = Color.white

//     var body: some View {
//         Button("Hello, World!") {
//             showingConfirmation = true
//         }
//         .frame(width: 300, height: 300)
//         .background(backgroundColor)
//         .confirmationDialog("Change background", isPresented: $showingConfirmation) {
//             Button("Red") { backgroundColor = .red }
//             Button("Green") { backgroundColor = .green }
//             Button("Blue") { backgroundColor = .blue }
//             Button("Cancel", role: .cancel) { }
//         } message: {
//             Text("Select a new color")
//         }
//     }
// }

// struct InstafilterOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         InstafilterOverview()
//     }
// }





// Integrating Core Image with SwiftUI – Instafilter SwiftUI Tutorial 4/13

// import CoreImage
// import CoreImage.CIFilterBuiltins

// struct InstafilterOverview: View {
//     @State private var image: Image?

//     var body: some View {
//         VStack {
//             image?
//                 .resizable()
//                 .scaledToFit()
//         }
//         .onAppear(perform: loadImage)
//     }

//     func loadImage() {
//         guard let inpImage = UIImage(named: "example") else { return } // Creates a UIImage object from our example image.
//         let beginImage = CIImage(image: inpImage) // convert that into a CIImage.

//         let context = CIContext() //  Creating a CIContext object. A Core Image context is an object that’s responsible for rendering a CIImage to a CGImage.
//         let currentFilter = CIFilter.pixellate() //  Creating a CIFilter object.

//         currentFilter.inputImage = beginImage /* assigns
// the original image (beginImage) as the input to the sepia tone filter (currentFilter).
//                                                Creating a CIFilter object, various properties become accessable to control the filter's behavior.
//                                                The inputImage property is one of these input properties, and it takes a CIImage("beginImage") as input*/
//         let amount = 1.0
//         let inputKeys = currentFilter.inputKeys

//         if inputKeys.contains(kCIInputIntensityKey) {
//             currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
//         if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
//         if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
//         // get a CIImage from our filter or exit if that fails
//         guard let outputImage = currentFilter.outputImage else { return }

//         // attempt to get a CGImage from our CIImage
//         guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

//         // convert that to a UIImage
//         let uiImage = UIImage(cgImage: cgImage)

//         // and convert that to a SwiftUI image
//         image = Image(uiImage: uiImage)
//     }
// }

// struct InstafilterOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         InstafilterOverview()
//     }
// }





// Showing empty states with ContentUnavailableView – Instafilter SwiftUI Tutorial 5/13

// struct InstafilterOverview: View {
//     var body: some View {
//         ContentUnavailableView {
//             Label("No snippets", systemImage: "swift")
//         } description: {
//             Text("You don't have any saved snippets yet.")
//         } actions: {
//             Button("Create Snippet") {
//                 // create a snippet
//             }
//             .buttonStyle(.borderedProminent)
//         } }
// }

// struct InstafilterOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         InstafilterOverview()
//     }
// }





// Loading photos from the user's photo library – Instafilter SwiftUI Tutorial 6/13

// import PhotosUI

// struct InstafilterOverview: View {
//     @State private var pickerItem: PhotosPickerItem?
//     @State private var selectedImage: Image?

//     var body: some View {
//         VStack {
//             PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)

//             selectedImage?
//                 .resizable()
//                 .scaledToFit()
//         }
//         .onChange(of: pickerItem) {
//             Task {
//                 selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
//             }
//         }
//     }
// }

// struct InstafilterOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         InstafilterOverview()
//     }
// }

// 6.1/13

// import PhotosUI

// struct InstafilterOverview: View {
//     @State private var pickerItems = [PhotosPickerItem]()
//     @State private var selectedImages = [Image]()

//     var body: some View {
//         VStack {
//             PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .any(of: [.images, .not(.screenshots)])) {
//                 Label("Select a picture", systemImage: "photo")
//             }

//             ScrollView {
//                 ForEach(0..<selectedImages.count, id: \.self) { i in
//                     selectedImages[i]
//                         .resizable()
//                         .scaledToFit()
//                 }
//             }
//         }
//         .onChange(of: pickerItems) {
//             Task {
//                 selectedImages.removeAll()

//                 for item in pickerItems {
//                     if let loadedImage = try await item.loadTransferable(type: Image.self) {
//                         selectedImages.append(loadedImage)
//                     }
//                 }
//             }
//         }
//     }
// }

// struct InstafilterOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         InstafilterOverview()
//     }
// }





// How to let the user share content with ShareLink – Instafilter SwiftUI Tutorial 7/13

// struct InstafilterOverview: View {
//     var body: some View {
//          let example = Image("example")

// //        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!)


//         // ShareLink(item: URL(string: "https://www.hackingwithswift.com")!, subject: Text("Learn Swift here"), message: Text("Check out the 100 Days of SwiftUI!"))


//         // ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
//         //     Label("Spread the word about Swift", systemImage: "swift")
//         // }

//          ShareLink(item: example, preview: SharePreview("Nature", image: example)) {
//              Label("Click to share", systemImage: "airplane")
//          }
//     }
// }

// struct InstafilterOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         InstafilterOverview()
//     }
// }





// How to ask the user to leave an App Store review – Instafilter SwiftUI Tutorial 8/13

// import StoreKit

// struct InstafilterOverview: View {
//     @Environment(\.requestReview) var requestReview
//     var body: some View {
//         Button("Leave a review") {
//             requestReview()
//         }
//     }
// }

// struct InstafilterOverview_Previews: PreviewProvider {
//     static var previews: some View {
//         InstafilterOverview()
//     }
// }
