//
//  TransactionsView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 9/24/21.
//

import SwiftUI

struct TransactionsView: View {
    @State private var showingPopover = false
    @State private var showingAlert = false
    
    var body: some View {
        Button("Show Menu") {
            showingPopover = true
        }
        Button("Show Alert"){
            showingAlert    =   true
        }
        .popover(isPresented: $showingPopover) {
            Text("Content is here")
                .font(.headline)
                .padding()
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK", role: .cancel){ }
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
