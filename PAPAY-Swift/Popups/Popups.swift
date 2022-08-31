//
//  Popups.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 6/28/22.
//

import SwiftUI

struct PopupMiddle: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            Image(uiImage: generateQRCode(from: UserDefaults.standard.string(forKey: "qrcode") ?? "testing"))
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            Text("Your QR Code")
                .foregroundColor(.black)
                .font(.system(size: 24))
                .padding(.top, 12)

            Text("Ask Client to align the camera to the QR Code to process the payment")
                .foregroundColor(.black)
                .font(.system(size: 16))
                .opacity(0.6)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            Button("Close") {
                isPresented = false
            }
            .buttonStyle(.plain)
            .font(.system(size: 18, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.horizontal, 24)
            .foregroundColor(.white)
            .background(Color(hex: "296BA6"))
            .cornerRadius(12)
        }
        .padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
        .background(Color.white.cornerRadius(20))
        .shadowedStyle()
        .padding(.horizontal, 40)
    }
    
    private func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter  =   CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        let transform = CGAffineTransform(scaleX: 5, y: 5)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage?.transformed(by: transform) {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct Popups_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
            PopupMiddle(isPresented: .constant(true))
        }
        
    }
}
