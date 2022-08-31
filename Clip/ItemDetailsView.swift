//
//  ItemDetailsView.swift
//  Clip
//
//  Created by Oskar Wong on 6/29/22.
//

import SwiftUI
import PassKit

struct ItemDetailsView: View {
    let words: String
    @State var isLinkActive = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image(words)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                HStack(alignment: .center, spacing: 10){
                    Spacer()
                    Text(words)
                        .fontWeight(.bold)
                    Text("-")
                    Text("Milk Base Coffee")
                        .fontWeight(.ultraLight)
                    Spacer()
                }
                List {
                    Section(header: Text("Espresso")) {
                        Text("Decaf")
                        Text("Regular")
                    }
                    Section(header: Text("Milk")) {
                        Text("Low Fat")
                        Text("Oat Milk")
                        Text("Regular Milk")
                        Text("Soy Milk")
                    }
                    
                }
                .listStyle(InsetGroupedListStyle())
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
       

//            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width - 100)
        Divider()
        HStack(alignment: .top, spacing: 16) {
            Image("fitness")
                .frame(width: 48, height: 48)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Select and Purchase")
                    .font(.system(size: 16, weight: .bold))
                Text("To order coffee, you need to Log in or purchase now")
                    .font(.system(size: 16))
                    .opacity(0.8)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                
                    NavigationLink(destination: PaymentView(paymentamount: "0.00"), isActive: $isLinkActive) {
                        Button(action: {self.isLinkActive = true}){
                            Text("Pay Now")
                                .frame(width: 112, height: 40)
                        }
                        .customButtonStyle(foreground: .white, background: Color(hex: "87B9FF"))
                        .cornerRadius(8)
                    }
//                        self.isShowing = false
                

//                Button {
////                        self.isShowing = false
//                } label: {
//                    Text("Log in")
//                        .frame(width: 112, height: 40)
//                }
//                .customButtonStyle(foreground: .white, background: Color(hex: "87B9FF"))
//                .cornerRadius(8)
            }
        }
        .foregroundColor(.black)
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 42, trailing: 16))
        .frame(maxWidth: .infinity)
        .background(Color.white)
            
        }
        
}
struct ApplePayButton: UIViewRepresentable {
        func updateUIView(_ uiView: PKPaymentButton, context: Context) {
    
        }
        func makeUIView(context: Context) -> PKPaymentButton {
                return PKPaymentButton(paymentButtonType: .plain, paymentButtonStyle: .black)
        }
}
struct ApplePayButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
             return ApplePayButton()
        }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailsView(words: "testing")
    }
}
