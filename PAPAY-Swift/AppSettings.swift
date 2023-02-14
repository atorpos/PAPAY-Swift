//
//  AppSettings.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 6/23/22.
//

import SwiftUI
import LocalAuthentication

struct AppSettings: View {
    @State private var showTaxi = false
    @State private var withBio = false
    @State private var kioksMode = false

    var body: some View {
        
        VStack {
            Toggle(isOn: $withBio, label: {
                Label("Bio Login", systemImage: "faceid")
            })
                .padding()
            
            if withBio {
                
            }
            Toggle(isOn: $showTaxi, label: {
                Label("Show taxi", systemImage: "car")
            })
                .padding()
            
            if showTaxi {
                
            }
            Toggle(isOn: $kioksMode, label: {
                Label("Kioks Mode", systemImage: "dollarsign.square")
            })
                .padding()
            if kioksMode {
                
            }
            Spacer()
        }
        .onAppear(perform: authenticate)
            .navigationTitle("App Settings")
    }
    
}

func authenticate() {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        let reason = "We need to unlocal your data"
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
            if success {
                
            } else {
                
            }
        }
    } else {
        
    }
}

struct AppSettings_Previews: PreviewProvider {
    static var previews: some View {
        AppSettings()
    }
}
