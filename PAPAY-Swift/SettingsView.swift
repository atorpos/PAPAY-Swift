//
//  SettingsView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 9/24/21.
//

import SwiftUI

struct SettingsView: View {
    let thewordings = ["About","Merchant Portal", "App Settings", "Help", "FAQ", "Term of Services", "Information Collection Statement"]
    var body: some View {
        NavigationView {
            List(thewordings, id: \.self) { theword in
                NavigationLink(destination: SettingDetailsView(words: theword)) {
                    Text(theword)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                    }) {
                        Text("Logout")
                        Image(systemName: "power.dotted")
                            .scaledToFit()
                        
                    }
                }
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
