import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@yoursite.com"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu { //contextMenu is similar to the right-click context menus you might be familiar with on desktop systems. 
                        ShareLink(item: Image(uiImage: qrCode), preview: //ShareLink is a button.
                                    SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateCode)//on appear of form call updateCode.
            .onChange(of: name, updateCode) //on change of name call updateCode.
            .onChange(of: emailAddress, updateCode)//on change of emailAddress call updateCode.
        }
    }
    
    func updateCode() {// is called when view is shown or when either the name or email address changes.
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)") // caching code
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {/*This is an optional binding. The code inside 
the if block will only execute if filter.outputImage successfully provides an image.*/
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
