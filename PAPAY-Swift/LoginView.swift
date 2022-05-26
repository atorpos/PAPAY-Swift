//
//  LoginView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 5/5/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewRouter: ViewRouter
    @State private var username: String = ""
    @State private var tid:String = ""
    @State private var password: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        ZStack(alignment: .center) {
            Image("login_1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                Form {
                    Image("pa_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical, 0.0)
                        .padding(.horizontal, 40.0)
                    
                    TextField("Merchant ID", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                    TextField("Terminal ID", text: $tid)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                    Button(action: {
                        let papaylogin = PapayLogin(mid: username, tid: Int(tid) ?? 0, password: password)
                        papaylogin.loginpapay()
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
                    .padding(.vertical, 150)
                    .padding(.horizontal, 20)
                    .onSubmit {
                        guard username.isEmpty == false || tid.isEmpty == false || password.isEmpty == false else {return}
                        print("Start working\(username)")
                        let connect_model = ConnectModel(url: PAPAYConfig().production_url, endpoint: PAPAYConfig().login_ep, token: "98765r6dtghud83", secret: "86t6ygyufeiehfuhfe", mid: username, tid: tid, password: password)
                        print(connect_model.getinfo())
                    }
                }
            }
        }
    }


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewRouter: ViewRouter()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct logininfo {
    var mid:String = ""
    var tid:String = ""
    var password:String = ""
    
    func testlogin() {
        print("info \(mid), \(tid), \(password)")
    }
}
