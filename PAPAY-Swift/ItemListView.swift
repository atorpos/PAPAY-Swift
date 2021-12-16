//
//  ItemListView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/17/21.
//

import SwiftUI

struct ItemListView: View {
    var body: some View {
        
        
        GeometryReader { geometer in
            VStack(alignment: .center, spacing: 0) {
                Text("the listview")
                Spacer(minLength: 40)
                HStack(alignment: .center, spacing: 100) {
                    Button(action: {
                        print("press button")
                    }) {
                        Text("testing")
                    }
                }
            }
            .frame(width: geometer.size.width, height: geometer.size.height, alignment: .leading)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
