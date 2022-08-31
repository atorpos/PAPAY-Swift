//
//  TransactionSearchVIew.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 7/19/22.
//

import SwiftUI

struct TransactionSearchView: View {
    @State private var date = Date()
    var body: some View {
        VStack {
            Text("Enter The Date")
                .font(.largeTitle)
            DatePicker("Enter the Date", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 400)
        }
    }
}

struct TransactionSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionSearchView()
    }
}

