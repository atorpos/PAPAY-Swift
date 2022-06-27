//
//  HomeView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/17/21.
//

import SwiftUI
import AVFoundation

class login_status: ObservableObject {
    @Published var logined = false
    
    func updatetheresponse() {
        let connect_model = PapayInfo()
        if(connect_model.infopapay() == "200") {
            logined = false
        } else {
            logined = true
        }
//        return logined
    }
    func update_fast_track(response_code: String) -> Bool{
        if(Int(response_code) == 200){
            logined = false
        } else {
            logined = true
        }
        return logined
    }
    func checkiflogin()->Bool {
        let connect_model = PapayInfo()
        if(connect_model.infopapay() == "200") {
            logined = false
//            return false
        } else {
            logined = true
//            return true
        }

        return logined
    }
    
}

struct HomeView: View {
    @State private var progress = 0.25
    @State private var loggedin:Bool = false
    @State private var username: String = ""
    @State private var tid:String = ""
    @State private var password: String = ""
    @StateObject var from_response = login_status()
//    @ObservedObject var login_process = login_status()
    
    init() {
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.darkGray]
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(red: 0.26, green: 0.45, blue: 0.67))
                        .frame(height: CGFloat(UiModel().screen_height)/4)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack{
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 48, weight: .ultraLight))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        Text(get_clip_info().merchant_name())
                            .font(.system(size: 28)
                                .weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                            .onAppear{
                                loggedin = checkiflogin()
                            }
                        Text("Terminal: \(get_clip_info().merchant_terminal())")
                            .font(.system(size: 14)
                                .weight(.light))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                            
                    }
                }
               balanceView()
            }
            
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                    }) {
                        Image(systemName: "power.dotted")
                            .scaledToFit()
                        
                    }
                }
            }
            
        }
        .fullScreenCover(isPresented: $loggedin) {
            NavigationView {
                VStack(alignment: .leading){
                    Form {
                        Image("pa_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.vertical, 0.0)
                            .padding(.horizontal, 40.0)
                        
                        TextField("Merchant ID", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .textInputAutocapitalization(.words)
                            .multilineTextAlignment(.center)
                            .textCase(.uppercase)
                        TextField("Terminal ID", text: $tid)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                        Button(action: {
                            let papaylogin = PapayLogin(mid: username, tid: Int(tid) ?? 0, password: password)
                            let responst_code:String = papaylogin.loginpapay()
                            print("response code \(responst_code)")
                            loggedin = loginresponse(response_code: responst_code)
                        }) {
                            HStack {
                                Spacer()
                                Text("Login")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Spacer()
                            }
                        }
                            .padding(.vertical, 10.0)
                            .padding(.horizontal, 50)
                            .background(Color.blue)
                            .cornerRadius(10.0)
                    }
                }
                
                Text("Login")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .principal){
                            Image("pa_logo")
                        }
                    }
            }
        }

    }
    func checkiflogin()->Bool {
        let connect_model = PapayInfo()
        if(connect_model.infopapay() == "200") {
            return false
        } else {
            return true
        }
    }
    func loginresponse(response_code:String)->Bool {
        if (Int(response_code) == 200) {
            return false
        } else {
            return true
        }
    }
}

struct balanceView: View {
    
    var body: some View {
        
        HStack{
//            Text("balance")
            Image(uiImage: generateQRCode(from: UserDefaults.standard.string(forKey: "qrcode") ?? ""))
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
//                        .onAppear{
//                            loggedin = checkiflogin()
//                        }
        }
        Spacer()
    }
    
    private func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter  =   CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

class get_clip_info{
    let appgroup:String = "group.com.paymentasia.papayswift"
    var terminal_name:String = ""
    var terminal_id:String = ""
    var terminal_amount:String = ""
    
    func merchant_name()->String {
        terminal_name = UserDefaults(suiteName: appgroup)?.string(forKey: "merchant_name") ?? "No Name"
        return terminal_name
    }
    func merchant_terminal()->String {
        terminal_id = UserDefaults(suiteName: appgroup)?.string(forKey: "terminal_id") ?? "000"
        return terminal_id
    }
    func merchant_amount()->String {
        terminal_amount = UserDefaults(suiteName: appgroup)?.string(forKey: "amount") ?? "0.00"
        return terminal_amount
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
