//
//  SettingDetails.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/15/21.
//

import SwiftUI
import WebKit

struct SettingDetailsView: View {
    
    let words: String
    @State private var get_action_type:String = ""
    @State private var showingAlert = false

    var body: some View {
        switch words {
            case "Help":
                Webview(url: URL(string: "https://www.papay.com.hk")!)
            case "FAQ":
                Webview(url: URL(string: "https://merchant.pa-sys.com/papay/faq")!)
            case "Term of Services":
                Webview(url: URL(string: "https://merchant.pa-sys.com/alipay/tnc")!)
            case "Information Collection Statement":
                Webview(url: URL(string: "https://www.paymentasia.com/ct/personal-information-collection-statement")!)
            case "About":
                Webview(url: URL(string: "https://www.paymentasia.com")!)
            case "Merchant Portal":
                Webview(url: URL(string: "https://s.awoz.co/js_test/")!)
            default:
                Text("Help")
        }
//        alert("testing", isPresented: $showingAlert) {
//            Button("OK", role: .cancel){ }
//        }
    }
}

struct Webview: UIViewRepresentable {
//    @Binding var text:String
    let url: URL

    func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
        let handler = MessageHandler()
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        configuration.userContentController.add(handler, name: "callbackHandler")
        let webview = WKWebView(frame: .zero, configuration: configuration)
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)

        return webview
    }

    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
    }
    
    
    class MessageHandler: NSObject, WKScriptMessageHandler {
        var set_type: String = ""
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            let externalclass = getwebsignal()
//            let param1 = message.body as?String
//            set_type = message.body as! String
            externalclass.set_type = message.body as? String
            print(externalclass.set_type ?? "nil")
        }
        
    }
}
