//
//  pa-connect.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 3/18/22.
//

import Foundation
import SwiftUI
import Combine

//class PaConnect: ObservedObject {
//    @Published var merchant_id   = ""
//    @Published var terminal_id   = ""
//    @Published var acc_password     = ""
//
//    var errorMessage = ""
//}

//extension PaConnect {
//    func loginUser() -> Bool {
//        let fcmtoken:String = UserDefaults.standard.object(forKey: "fcmtoken")! as! String
//        let payload: [String : Any] = [
//            "merchant_id":merchant_id,
//            "terminal_id": terminal_id,
//            "password": acc_password,
//            "fcm_token": fcmtoken
//        ]
//        
//    }
//    
//}


class connecttoservice {
    var mid:String?
    var tid:Int?
    var token:String?
    
    public func palogin() {
        
    }
}

class getwebsignal{
    var set_type:String?
    
    public func grabsignal(){
        
    }
    
}
