//
//  DigitDisplayView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/25/21.
//

import SwiftUI

struct DigitDisplayView: View {
    
    var body: some View {
        GeometryReader {viewsize in
            Text("testing")
                .frame(width: viewsize.size.width, height: viewsize.size.height, alignment: .center)
            
        }
        
    }
}

struct DigitDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DigitDisplayView()
    }
}
