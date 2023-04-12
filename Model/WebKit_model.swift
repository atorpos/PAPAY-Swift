//
//  WebKit_model.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 8/17/22.
//

import Foundation
import WebKit
import SwiftUI

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
