//
//  PaymentView.swift
//  Clip
//
//  Created by Oskar Wong on 7/4/22.
//

import SwiftUI
import PassKit

struct PaymentView: View {
    @State private var showWebView = false
    
    let paymentamount: String
    
    var body: some View {
        VStack(alignment: .center) {
            Button {
                showWebView.toggle()
            } label: {
                Text("Show Alipay")
            }
            Button(action: {runapplewallet()}, label: {Text("")})
                .frame(width: 212, height: 38, alignment: .center)
                .buttonStyle(ApplewalletButtonStyle())
            .sheet(isPresented: $showWebView) {
                WebView(url: URL(string: "https://payment.pa-sys.com/app/page/115e1da8-8d8a-4f9b-a8a8-302f866e4a95/d048a63c-e6c9-4971-8315-65f99226b42a/")!)
            }
        }
        
    }
    private func runapplewallet(){
        let url = URL(string: "http://admin.mg.awoz.co/wallets/sample01.pkpass")
        UIApplication.shared.open(url!)
//        FileDownloader.loadFileSync(url: url!) {(path, error) in
//            print("test")

        }
}

struct ApplewalletButton: UIViewRepresentable {
        func updateUIView(_ uiView: PKAddPassButton, context: Context) {
    
        }
        func makeUIView(context: Context) -> PKAddPassButton {
            let scale = CGFloat(floatLiteral: 0.75)
            let passButton = PKAddPassButton(addPassButtonStyle: PKAddPassButtonStyle.black)
            passButton.frame = CGRect(x:  (UIScreen.main.bounds.width-280)/2, y: 150, width: 280, height: 60)
            passButton.transform = CGAffineTransform(scaleX: scale, y: scale)
            return passButton
        }
}

struct ApplewalletButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
             return ApplewalletButton()
        }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(paymentamount: "0.00")
    }
}
