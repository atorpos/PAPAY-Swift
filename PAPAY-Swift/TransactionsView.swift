//
//  TransactionsView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 9/24/21.
//

import SwiftUI

struct TransactionsView: View {
    @State private var showingPopover = false
    
    var body: some View {
        Button("Show Menu") {
            showingPopover = true
        }
        .popover(isPresented: $showingPopover) {
            Text("Content is here")
                .font(.headline)
                .padding()
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
