//
//  iPadHomeView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/17/21.
//

import SwiftUI

struct iPadHomeView: View {
    let colors: [Color] =
        [.red, .orange, .yellow, .green, .blue, .purple]
    
    var body: some View {
        GeometryReader { geometer in
            HStack(alignment: .center, spacing: 0   ) {
                VStack(alignment: .center, spacing: 0) {
                    DigitDisplayView()
                        .frame(height: geometer.size.height/20, alignment: .center)
                    keypadView()
                }
                Spacer()
                ItemListView()
                    .frame(width: geometer.size.width*0.30, height: geometer.size.height)
            }
        }
    }
}

@available(iOS 15.0, *)
struct iPadHomeView_Previews: PreviewProvider {
    static var previews: some View {
        iPadHomeView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
