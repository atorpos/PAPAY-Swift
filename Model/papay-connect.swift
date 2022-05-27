//
//  papay-connect.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 5/16/22.
//

import Foundation

class PapayLogin {
    var merchant_id: String = ""
    var terminal_id: Int = 0
    var acc_password: String = ""
    let login_url: String = PAPAYConfig().production_url+PAPAYConfig().login_ep
    
    init(mid: String, tid: Int, password: String){
        
        merchant_id = mid
        terminal_id = tid
        acc_password    =   password
    }
    
    func loginpapay() {
        let fcmtoken:String = UserDefaults.standard.object(forKey: "fcmtoken")! as! String
        let connect_gateway = PapayConnect()
        let payload: [String : Any] = [
            "merchant_id":merchant_id,
            "terminal_id": terminal_id,
            "password": acc_password,
            "fcm_token": fcmtoken
        ]
        
        connect_gateway.request_enpoint = login_url
        connect_gateway.request_payload = getPostString(params: payload)
        
        return connect_gateway.connect_backend()
        
    }
    func getPostString(params:[String:Any]) -> String
        {
            var data = [String]()
            for(key, value) in params
            {
                data.append(key + "=\(value)")
            }
            return data.map { String($0) }.joined(separator: "&")
        }
    
}


class PapayGeneral {
    
    var terminal_token: String = ""
    var choose_endpoint: String = ""
    var cho_service: String = ""
    
    init(token: String, choose_service: String){
        cho_service =   choose_service
        terminal_token = token
        switch choose_service {
            case "info":
                choose_endpoint = PAPAYConfig().information_ep
                break;
            case "onetimepw":
                choose_endpoint = PAPAYConfig().onetime_ep
                break;
            case "heartbeat":
                choose_endpoint = PAPAYConfig().heartbeat_ep
                break;
            default:
                choose_endpoint = PAPAYConfig().login_ep
                break;
        }
        
    }
    func connect_service() {
        let connect_gateway = PapayConnect()
        let payload = "{\"\(terminal_token)\"}"
        connect_gateway.request_enpoint = choose_endpoint
        connect_gateway.request_payload = payload
        
        return connect_gateway.connect_backend()
        
    }
    
}

class PapayConnect {
    var request_enpoint: String = ""
    var request_payload: String = ""
    
    func connect_backend() {
        let payload = request_payload.data(using: .utf8)
        var request = URLRequest(url: URL(string: request_enpoint)!)
        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return}
            guard let data = data else {print("Empty data"); return}
            
            if let str = String(data: data, encoding: .utf8){
                print(str)
            }
        }.resume()
        
    }
    
}
