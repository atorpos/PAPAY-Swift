//
//  FirstView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 9/16/21.
//

import SwiftUI

struct FirstView: View {
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
                            
                        }) {
                            Image(systemName: "info.circle")
                                .scaledToFit()
                            
                        }
                        Button(action: {
                            
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                        }
                    }
                }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
