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
                Webview(url: URL(string: "https://merchant.pa-sys.com")!)
            default:
                Text("Help")
        }
    }
}

struct Webview: UIViewRepresentable {
    let url: URL

    func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
        let webview = WKWebView()

        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)

        return webview
    }

    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
    }
}
