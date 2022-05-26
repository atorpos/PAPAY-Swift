//
//  HomeView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/17/21.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        let _model = ConnectModel(url: PAPAYConfig().production_url, endpoint: PAPAYConfig().login_ep, token: "98765r6dtghud83", secret: "86t6ygyufeiehfuhfe", mid: "2018-PAPAY", tid: "1061", password: "demo1234")
        Image(uiImage: generateQRCode(from: _model.getinfo()))
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
        
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
//    var login = ConnectModel()
    private func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter  =   CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
