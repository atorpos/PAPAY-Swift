//
//  BalanceView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 6/28/22.
//

import SwiftUI

struct BalanceView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text("Current Tranactions")
                .font(.subheadline)
                Spacer()
            VStack(alignment: .center, spacing: 8){
                Spacer()
                Text("HKD 0.00")
                    .font(.headline)
                Spacer()
            }
            VStack(alignment: .leading, spacing: 4){
                Button{
                    print("Testing")
                } label: {
                    Text("Transaactions")
                }
            }
//            Text("Testing")
//                .font(.subheadline)
            Spacer()
        }
        .foregroundColor(.black)
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 42, trailing: 16))
        .frame(maxWidth: .infinity)
        .background(Color.white)
        
    }
}

struct second_view: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "globe.americas")
                .frame(width: 48, height: 48)
                .cornerRadius(24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Subscription completed!")
                    .font(.system(size: 16, weight: .bold))
                Text("The next charge to your credit card will be made on May 25, 2022.")
                    .font(.system(size: 16, weight: .light))
                    .opacity(0.8)
            }
            
//            Spacer()
        }
        .foregroundColor(.black)
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 42, trailing: 16))
        .frame(maxWidth: .infinity)
//        .background(Color.white)
        .shadow(color: .black.opacity(0.1), radius: 40, x: 0, y: -4)
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Rectangle()
                .ignoresSafeArea()
            VStack {
                BalanceView()
                second_view()
            }
        }
        
    }
}
