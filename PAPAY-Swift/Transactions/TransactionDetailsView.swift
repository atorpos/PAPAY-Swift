//
//  TransactionDetailsView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 8/16/22.
//

import SwiftUI
import WebKit

struct TransactionDetailsView: View {
    let Request_reference:String
    let appgroup:String = "group.com.paymentasia.papayswift"
//    let gottoken:String = UserDefaults(suiteName: appgroup)?.string(forKey: "token") ?? ""
    var body: some View {
        if ((UserDefaults(suiteName: appgroup)?.string(forKey: "token")) != nil) {
//            Text("\(Request_reference) - \((UserDefaults(suiteName: appgroup)?.string(forKey: "token"))!)")
//                .navigationTitle("Transaction")
            let urlstring:String = "https://merchant.pa-sys.com/transaction-detail/?token="+((UserDefaults(suiteName: appgroup)?.string(forKey: "token"))!)+"&request_reference="+Request_reference
            Webview(url: URL(string: urlstring)!)
        } else {
            Text("no input")
                .navigationTitle("Transaction")
        }
        
            
    }
}

//struct Webview: UIViewRepresentable {
////    @Binding var text:String
//    let url: URL
//
//    func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
//        let handler = MessageHandler()
//        let configuration = WKWebViewConfiguration()
//        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
//        configuration.userContentController.add(handler, name: "callbackHandler")
//        let webview = WKWebView(frame: .zero, configuration: configuration)
//        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
//        webview.load(request)
//
//        return webview
//    }
//
//    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
//        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
//        webview.load(request)
//    }
//
//
//    class MessageHandler: NSObject, WKScriptMessageHandler {
//        var set_type: String = ""
//        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//            let externalclass = getwebsignal()
////            let param1 = message.body as?String
////            set_type = message.body as! String
//            externalclass.set_type = message.body as? String
//            print(externalclass.set_type ?? "nil")
//        }
//
//    }
//}



//struct TransactionDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionDetailsView(Request_reference: "no")
//    }
//}
