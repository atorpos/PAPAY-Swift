//
//  ContentView.swift
//  Clip
//
//  Created by Oskar Wong on 6/13/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
        Text(gettoken())
    }
}

func gettoken() -> String {
    let appgroup:String = "group.com.paymentasia.papayswift"
    let testStr: String! = UserDefaults(suiteName: appgroup)?.string(forKey: "token") ?? ""
    print(testStr ?? "")
    
    return testStr ?? "no token"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
