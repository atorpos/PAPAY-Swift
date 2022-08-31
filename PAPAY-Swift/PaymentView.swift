//
//  PaymentView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 6/29/22.
//

import SwiftUI

struct PaymentView: View {
    var body: some View {
        NavigationView {
            iPhoneKeypadView()
            
//            VStack {
//                NavigationLink{
//                    ScannerView()
//                } label: {
//                    Text("show the time")
//                }
//
//            }
//            .navigationTitle("PaymentPage")
            .navigationBarHidden(true)
        }
        
        
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
