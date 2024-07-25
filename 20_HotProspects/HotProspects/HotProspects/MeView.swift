//
//  MeView.swift
//  HotProspects
//
//  Created by Prathamesh Sonawane on 21/07/24.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @AppStorage("name") var name = "Anonymous"
    @AppStorage("emailAddress") var emailAddress = "emailAddress@email.com"
    @State private var qrCode = UIImage()
     
    let context = CIContext()
    let filter =  CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name: ", text: $name)
                    .textContentType(.name)
                    .font(.title3)
                
                TextField("Email: ", text: $emailAddress)
                    .textContentType(.emailAddress)
                
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                    }
            }
            .navigationTitle("Your Code")
            .onAppear {
                updateCode()
            }
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode )
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage =  context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
}

#Preview {
    MeView()
}
