//
//  SettingDetails.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/15/21.
//

import SwiftUI
import WebKit
import Combine

struct SettingDetailsView: View {
    
    let words: String
    @State private var get_action_type:String = ""
    @State private var showingAlert = false
    @State var showaction = ""
//    @ObservedObject var trial_mag: MessageHandler
//    @ObservedObject var trail_2 = MessageHandler()
    @StateObject var trail_2 = MessageHandler()

    var body: some View {
        switch words {
            case "Help":
                Webview(url: URL(string: "https://www.papay.com.hk")!)
                    .navigationTitle(words)
            case "FAQ":
                Webview(url: URL(string: "https://merchant.pa-sys.com/papay/faq")!)
                    .navigationTitle(words)
            case "Term of Services":
                Webview(url: URL(string: "https://merchant.pa-sys.com/alipay/tnc")!)
                    .navigationTitle(words)
            case "Information Collection Statement":
                Webview(url: URL(string: "https://www.paymentasia.com/ct/personal-information-collection-statement")!)
                    .navigationTitle(words)
            case "About":
                Webview(url: URL(string: "https://www.paymentasia.com")!)
                    .navigationTitle(words)
            case "Merchant Portal":
                VStack {
                    Webview(url: URL(string: "https://s.awoz.co/js_test/")!)
                    if let check_response = trail_2.set_type {
                        Text(check_response)
                    }
                    
                }
                    .navigationTitle(trail_2.set_type)
            case "App Settings":
                AppSettings()
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
//    @Binding var gettext: String = ""

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
    
}
class MessageHandler: NSObject, WKScriptMessageHandler, ObservableObject {
    @Published var set_type: String = ""
//    let env = SettingDetailsView(words: "")
//    env.
    
//    @ObservableObject var test_type: String = ""
//    @Binding var gettext: String
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let externalclass = getwebsignal()
//            let param1 = message.body as?String
//            set_type = message.body as! String
        externalclass.set_type = message.body as? String
//        print(externalclass.set_type ?? "nil")
//        gettext = externalclass.set_type!
        
        self.set_type = self.export_value(exp_getvalue: externalclass.set_type!)
        print(set_type)
//        if(set_type == "touchid"){
//            print("one touch id")
//        } else if(set_type == "camera") {
//            print("two camera")
//        }
//        print(set_type)
//        set_type = (message.body as? String)!
//        test_type = (message.body as? String)!
        
    }
    func export_value(exp_getvalue: String)->String {
        let outputvalue: String
        switch exp_getvalue {
            case "touchid":
                outputvalue = "pressed the touch id export value"
            case"camera":
                outputvalue = "pressed camera export value"
                showUser(email: "show camera", name: "touch id")
            default:
                outputvalue = "nothing"
        }
        return outputvalue
    }
    private func showUser(email: String, name: String) {
        print(email+name)
//        let userDescription = "\(email) \(name)"
//        let alertController = UIAlertController(title: "User", message: userDescription, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .default))
//
//        let viewController = UIApplication.shared.windows.first!.rootViewController!
//        viewController.present(alertController, animated: true, completion: nil)
        
//        let vc = UIHostingController(rootView: SettingsView())
//        NavigationLink(destination: SettingsView(), label: {Text("")})
        
//        present(alertController, animated: true)
    }
    
}

//extension View:WKScriptMessageHandler {
//
//
//
//}
