//
//  ProcessingView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 7/19/22.
//

import SwiftUI
import CoreLocationUI

struct ProcessingView: View {
    let theqrcode:String
    let theamount:String
    @State private var showReaction = false
    @State private var startQuery = false
    let inboundBubbleColor = Color(#colorLiteral(red: 0.07058823529, green: 0.07843137255, blue: 0.0862745098, alpha: 1))
    let reactionsBGColor = Color(#colorLiteral(red: 0.05490196078, green: 0.09019607843, blue: 0.137254902, alpha: 1))
    @State var timerRemaining = 0
    @State var transaction_request_response = ""
    @State var transaction_status = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        if(transaction_status == 0){
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("\(String(format: "HKD %.2f", convertStDo()))")
                        .font(.system(size: 80, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                    Image(systemName: "clock.arrow.2.circlepath")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(.white)
    //                    .animation(Animation.easeInOut(duration: 1.0), value: 300)
                        .animation(.spring(response: 1.5), value: true)
                    Text("Processing")
                        .font(.system(size: 30, weight: .light))
                        .foregroundColor(.white)
                    RoundedRectangle(cornerRadius: 28)
                        .frame(width: 216, height: 40)
                        .foregroundColor(Color(.systemGray6))
                        .scaleEffect(CGFloat(showReaction ? 1 : 0), anchor: .topTrailing)
                        .animation(.interpolatingSpring(stiffness: 170, damping: 15).delay(0.05), value: showReaction)
                    HStack(spacing: 20) {
                        Text("\(timerRemaining)")
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                            .onReceive(timer) { _ in
                                if timerRemaining > 0 {
                                    timerRemaining -= 1
                                } else if timerRemaining == 0 {
                                    self.run_loop()
                                    timerRemaining = 5
                                }
                            }
                        if let location = locationManager.location {
                            Text("Your Location: \(location.latitude), \(location.longitude)")
                        }
//                        Text("Status \(transaction_status)")
//                            .font(.system(size: 24, weight: .medium, design: .rounded))
//                            .foregroundColor(.white)
    //                    Image("heart")
    //                        .offset(x: showReaction ? 0 : -15)
    //                        .scaleEffect(showReaction ? 1 : 0, anchor: .bottomLeading)
    //                        .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.1), value: showReaction)
    //
    //                    Image("thumbup")
    //                        .offset(x: showReaction ? 0 : -15)
    //                        .scaleEffect(showReaction ? 1 : 0, anchor: .bottom)
    //                        .rotationEffect(.degrees(showReaction ? 0 : -45))
    //                        .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.2), value: showReaction)
    //
    //                    Image("thumbdown")
    //                        .scaleEffect(showReaction ? 1 : 0, anchor: .topTrailing)
    //                        .rotationEffect(.degrees(showReaction ? 0 : 45))
    //                        .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.3), value: showReaction)
    //
    //                    Image("crying")
    //                        .scaleEffect(showReaction ? 1 : 0, anchor: .bottom)
    //                        .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.4), value: showReaction)
    //
    //                    Image("sad")
    //                        .offset(x: showReaction ? 0 : 15)
    //                        .scaleEffect(showReaction ? 1 : 0, anchor: .bottomTrailing)
    //                        .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.5), value: showReaction)
                        
                    }
                    .onAppear{
                        showReaction.toggle()
                        locationManager.requestLocation()
                    }
//                    LocationButton {
//                        locationManager.requestLocation()
//                    }
                    Spacer()
                }
            }
        } else if (transaction_status == 1){
            SuccessView
        } else {
            Failview
        }
    }
    
    var Failview: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("\(String(format: "HKD %.2f", convertStDo()))")
                    .font(.system(size: 80, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                Image(systemName: "checkmark.circle.trianglebadge.exclamationmark")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.white)
                Text("Fail")
                    .font(.system(size: 30, weight: .light))
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
    
    var SuccessView: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("\(String(format: "HKD %.2f", convertStDo()))")
                    .font(.system(size: 80, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.white)
                Text("Success")
                    .font(.system(size: 30, weight: .light))
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
    
    func convertStDo() -> Double {
        
        let doubleamount:Double = Double(theamount) ?? 0.00
        
        return doubleamount
    }
    
    func run_loop() {
//        let currency = "HKD"
//        let tansaction_url = "https://gateway.pa-sys.com/papay/qrcode-recognition"
//        let appgroup:String = "group.com.paymentasia.papayswift"
//        let trans_token = UserDefaults(suiteName: appgroup)?.string(forKey: "token") ?? "no token"
        let papay_request = PapayRequest()
        papay_request.request_amount = theamount
        papay_request.the_qrcode = theqrcode
        if (Double(theamount) ?? 0.0 > 100000.00 || Double(theamount) ?? 0.0 < 0.1) {
            print("show error amount")
        }
        
        if(startQuery == false){
            let request_response = papay_request.requestpapay()
            let responsedata = Data(request_response.utf8)
            let decoder = JSONDecoder()
            do {
                let ser_response = try decoder.decode(RequestResponse.self, from: responsedata)
                print("checkout \(String(describing: ser_response.payload.transaction_status))")
                transaction_status = Int(ser_response.payload.transaction_status ?? "2")!
                transaction_request_response = ser_response.payload.request_reference ?? "nan"
            } catch {
                print(String(describing: error))
            }
            
        } else {
            papay_request.request_reference = transaction_request_response
            let query_response = papay_request.querypapay()
            let responsedata = Data(query_response.utf8)
            let decoder = JSONDecoder()
//            print("get request \(transaction_request_response)")
//            print("query \(papay_request.querypapay())")
            do {
                let ser_response = try decoder.decode(RequestResponse.self, from: responsedata)
                print("checkout \(String(describing: ser_response.payload.status))")
                
                transaction_status = Int(ser_response.payload.status!)!
                print("Address \(String(describing: ser_response.payload.merchant_store_address))")
            } catch {
                print("error: \(String(describing: error))")
            }
        }
        startQuery = true
//        print(trans_token)
    }
}



struct ProcessingView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessingView(theqrcode: "zero", theamount: "0.00")
    }
}
