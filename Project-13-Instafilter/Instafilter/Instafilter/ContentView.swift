import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit
import PhotosUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone() /* CIFilter.sepiaTone() returns a CIFilter object
     that conforms to the CISepiaTone protocol. That protocol then exposes the intensity parameter we’ve been using,
     but internally it will just map it to a call to setValue(_:forKey:). */
    let context = CIContext()
    @State private var showingFilters = false
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    @State private var filterRadius: Double = 0.5
    @State private var filterScale: Double = 0.5
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage:
                                                "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage) // on change of selectedItem call loadImage

                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                        .disabled(selectedItem == nil) // Current Project Challenge 1
                }
                .padding(.vertical)

                 HStack {               // Current Project Challenge 2
                    Text("Radius")
                    Slider(value: $filterRadius)
                        .onChange(of: filterRadius, applyProcessing)
                        .disabled(selectedItem == nil)
                }
                .padding(.vertical)

                HStack {                // Current Project Challenge 2
                    Text("Scale")
                    Slider(value: $filterScale)
                        .onChange(of: filterScale, applyProcessing)
                        .disabled(selectedItem == nil)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                    .disabled(selectedItem == nil) // Current Project Challenge 1
                    
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) { /* This works identically to alert(): we
provide a title and condition to monitor, and as soon as the condition becomes true the confirmation dialog will be shown. */
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }

                Button("Bump Distortion") { setFilter(CIFilter.bumpDistortion()) } // Current Project Challenge 3
                Button("Color Invert") { setFilter(CIFilter.colorInvert()) }
                Button("Hue Adjustment") { setFilter(CIFilter.hueAdjust()) }

                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        // currentFilter.intensity = Float(filterIntensity) // set the intensity of the filter.
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        // read the output image from our filter.
        guard let outputImage = currentFilter.outputImage else { return }
        //convert the output image into actual pixels. from: outputImage.extent specifies the actual size we want to work with dont read part of it read all of it in this case with "outputImage.extent".
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage) // convert to UIImage
        processedImage = Image(uiImage: uiImage) // convert to SwiftUI Image
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}

