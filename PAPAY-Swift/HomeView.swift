//
//  HomeView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/17/21.
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    @State private var progress = 0.25
    @State private var loggedin:Bool = false
    
    init() {
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.darkGray]
    }
    
    var body: some View {
        NavigationView {
            Image(uiImage: generateQRCode(from: UserDefaults.standard.string(forKey: "qrcode") ?? ""))
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .onAppear{
                    loggedin = checkiflogin()
                }
            Image("pa-logo")
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                        }) {
                            Image(systemName: "power.dotted")
                                .scaledToFit()
                            
                        }
                    }
                }
        }
        .onAppear(perform: biomatmodel().authenticate)
        .fullScreenCover(isPresented: $loggedin) {
            NavigationView {
                Text("Login")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .principal){
                            Image(systemName: "video.fill")
                        }
                    }
            }
        }
//        let sp_model = texttospeech(read_text: "Testing", speech_lang: "en-US")
        
        
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
    func checkiflogin()->Bool {
        let connect_model = PapayInfo()
        if(connect_model.infopapay() == "200") {
            return false
        } else {
            return true
        }
        
//        print(connect_model.infopapay())
    }
    
//    public func runsound() {
//
//        let utterance = AVSpeechUtterance(string: "test")
//
//        utterance.voice = AVSpeechSynthesisVoice(language: "zh-HK")
////        utterance.rate = 0.8
//        print("showsound")
//        let synthesizer = AVSpeechSynthesizer()
//        synthesizer.speak(utterance)
//    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
