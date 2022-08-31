//
//  HomeView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/17/21.
//

import SwiftUI
import AVFoundation
import ExytePopupView
import CoreLocation

class login_status: ObservableObject {
    @Published var logined = false
    private var locationManager:CLLocationManager?
    
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
    @State var tid_balance: Double = 0.00
    @State var tid_name: String = ""
    @State var tid_id: String = ""
    @State var tid_channels: [String] = []
    @StateObject var from_response = login_status()
    @StateObject var locationManager = LocationManager()
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
//                        Text(get_clip_info().merchant_name())
                        Text(tid_name)
                            .font(.system(size: 28)
                                .weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                            .onAppear{
                                loggedin = checkiflogin()
                                locationManager.requestLocation()
                            }
                        if let location = locationManager.location {
                            Text("Your Location: \(location.latitude), \(location.longitude)")
                                .font(.system(size: 12)
                                    .weight(.light))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.white)
                        }
                        Text("Terminal: \(tid_id)")
                            .font(.system(size: 14)
                                .weight(.light))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                        HStack(alignment: .center, spacing: 10){
                            Spacer()
                            ForEach(0 ..< tid_channels.count, id:\.self) { value in
                                Image(tid_channels[value])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
    //                            Text("\(tid_channels[value])")
                            }
                            Spacer()
                        }
                    }
                }
                Spacer()
                VStack {
                    HStack(){
                        Text("Total Amount")
                            .font(.system(size: 18, weight: .ultraLight, design: .rounded))
                        Spacer()
                    }
                    HStack(alignment: .center, spacing: 10){
                        Spacer()
                        Text(String(format: "HKD $%.2f", tid_balance))
                            .font(.system(size: 48, weight: .ultraLight, design: .rounded))
                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        Spacer()
                    }
                }
                .padding()
               bottomView()
            }
            
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.loggedin = self.logoutaction()
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
        let appgroup:String = "group.com.paymentasia.papayswift"
        let connect_model = PapayInfo()
        let connect_str = connect_model.infopapay_str()
        let responsedata = Data(connect_str.utf8)
        var responsecode: Int = 400
        let decoder = JSONDecoder()
        getUserLocation()
        do {
            let ser_response = try decoder.decode(InfoResponse.self, from: responsedata)
            responsecode = Int(ser_response.response.code) ?? 400
            self.tid_balance = Double(ser_response.payload.amount) ?? 0.00
            self.tid_name = ser_response.payload.name
            self.tid_id = ser_response.payload.terminal_id
            for app_url  in ser_response.payload.screen_saver {
                print(app_url)
            }
            self.tid_channels = UserDefaults(suiteName: appgroup)?.stringArray(forKey: "channels") ?? [String]()
            for channel in tid_channels {
                print(channel)
            }
        } catch {
            print(String(describing: error))
        }
        
        if(responsecode == 200) {
            return false
        } else {
            return true
        }
    }
    func loginresponse(response_code:String)->Bool {
        let appgroup:String = "group.com.paymentasia.papayswift"
        if (Int(response_code) == 200) {
            self.tid_name = UserDefaults(suiteName: appgroup)?.string(forKey: "merchant_name") ?? "Merchant Name"
            self.tid_channels = UserDefaults(suiteName: appgroup)?.stringArray(forKey: "channels") ?? [String]()
            return false
        } else {
            return true
        }
    }
    func logoutaction()->Bool {
        let appgroup:String = "group.com.paymentasia.papayswift"
        UserDefaults(suiteName: appgroup)?.removeObject(forKey: "qrcode")
        UserDefaults(suiteName: appgroup)?.removeObject(forKey: "signature_secret")
        UserDefaults(suiteName: appgroup)?.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "qrcode")
        UserDefaults.standard.removeObject(forKey: "signature_secret")
        UserDefaults.standard.removeObject(forKey: "token")
        
        return true
    }
    func getUserLocation() {
        locationManager.requestPermission()
        locationManager.requestLocation()
    }
        
}


struct bottomView: View {
    @State var showqrwindow = false
    
    var body: some View {
        VStack{
            VStack(alignment: .center) {
                Spacer()
                Button("Show QRCode") {
                    showqrwindow.toggle()
                }
                .buttonStyle(.plain)
                .font(.system(size: 20, weight: .bold))
                .frame(maxWidth: 240)
                .padding(.vertical, 18)
                .padding(.horizontal, 24)
                .foregroundColor(.white)
                .background(Color(hex: "296BA6"))
                .cornerRadius(18)
                Spacer()
            }
        }
        
        .popup(isPresented: $showqrwindow, type: .default, closeOnTap: true, backgroundColor: .white.opacity(1)) {
            PopupMiddle(isPresented: $showqrwindow)
        }
    }
    
    private func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter  =   CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        let transform = CGAffineTransform(scaleX: 5, y: 5)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage?.transformed(by: transform) {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    func showpopup()->Bool {
        showqrwindow = true
        return showqrwindow
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

struct qrcodeview: View {
    
    var body: some View {
        Text("texting")
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
