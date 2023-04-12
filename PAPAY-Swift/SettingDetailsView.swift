//
//  SettingDetails.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/15/21.
//

import SwiftUI
import WebKit
import Combine

class PunchProcess: ObservableObject {
    @Published var live_stauts = ""
}

struct SettingDetailsView: View {
    
    let words: String
    @State private var get_action_type:String = ""
    @State private var showingAlert = false
    @State var showaction = ""
    @ObservedObject var trail_2 = MessageHandler()
    @ObservedObject var trail_4 = PunchProcess()
    @StateObject var trial_3 = PunchProcess()

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
//                    if let check_response = trail_2.set_type {
//                        Text(check_response)
//                    } else {
//                        Text("nothing")
//                    }
                    Text("testing \(trail_2.set_type)")
                        .foregroundColor(.blue)
                }
                    .navigationTitle(trail_2.set_type)
            case "App Settings":
                AppSettings()
            default:
                Text("Help")
        }
    }
}

class MessageHandler: NSObject, WKScriptMessageHandler, ObservableObject {
    @Published var set_type:String = ""
    @Published var show_type = PunchProcess()
//    @ObservedObject var set_type_2: MessageHandler
    

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let externalclass = getwebsignal()
        externalclass.set_type = message.body as? String
        
        set_type = self.export_value(exp_getvalue: externalclass.set_type!)
        show_type.live_stauts = set_type
        print(show_type.live_stauts)
        
        
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
    }
}
