//
//  FirstView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 9/16/21.
//

import SwiftUI

struct FirstView: View {
    @State private var showingAlert = false
    var body: some View {
        let _dimension = UiModel()
        let _window_width: Float = _dimension.screen_width
        
        NavigationView {
            Text(String(format: "%.1f",_window_width))
                .navigationTitle("Report")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAlert = true
                        }) {
                            Image(systemName: "info.circle")
                                .scaledToFit()
                            
                        }
                        Button(action: {
                            actionsheet()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                        }
                    }
                }
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK", role: .cancel){ }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}

func actionsheet() {
    guard let urlShare = URL(string: "https://www.paymentasia.com") else {return}
    let activeityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(activeityVC, animated: true, completion: nil)
}
