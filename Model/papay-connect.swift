//
//  papay-connect.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 5/16/22.
//

import Foundation
import SwiftUI
import Combine

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
    
    func loginpapay() -> String {
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
//        var response_string: String
//        let request = URLRequest(url: URL(string: login_url)!)
        return connect_gateway.connect_backend()
//        return connect_gateway.connect_back(withRequest: request, withCompletion: {response_string, error in
//            if let error = error {
//                print(error)
//                return
//            }
//        }->Void)
        
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

class PapayInfo {
    let info_url: String = PAPAYConfig().production_url+PAPAYConfig().information_ep
    let appgroup:String = "group.com.paymentasia.papayswift"

    func infopapay()-> String {
        
        let gottoken:String = UserDefaults(suiteName: appgroup)?.string(forKey: "token") ?? ""
//        let gottoken:String = UserDefaults.standard.object(forKey: "token")! as! String
        let connect_gateway = PapayConnect()
        let payload: [String: Any] = [
            "token":gottoken
        ]
        var response_values: String = ""
        connect_gateway.request_enpoint = info_url
        connect_gateway.request_payload = connect_gateway.getPostString(params: payload)
        response_values = connect_gateway.connect_backend()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
        print("returncode \(response_values)")
//        }
        
        
        return response_values
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
    func connect_service() -> String {
        let connect_gateway = PapayConnect()
        let payload = "{\"\(terminal_token)\"}"
        connect_gateway.request_enpoint = choose_endpoint
        connect_gateway.request_payload = payload
        
        return connect_gateway.connect_backend()
        
    }
    
}
struct DS_response: Decodable {
    let request: String
    let response: String
    let payload: String
    
}


class Direct_esponse{
    var direct_token:String = ""
    
    func read_sentence(){
        print("testing")
        
        let response_data = try? JSONSerialization.data(withJSONObject: direct_token.data(using: .utf8) as Any, options: .prettyPrinted)
        print(response_data as Any)
        
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//        let ds_response: DS_response = try! decoder.decode(DS_response.self, from: direct_token.data(using: .utf8)!)
//        print(ds_response.response)
    }
}

class PapayConnect {
    @Published var request_enpoint: String = ""
    @Published var request_payload: String = ""
    
    struct ResponseStructure: Codable{
        var request:String
        var response:String
        var payload:String
    }
    
    func connect_backend()->String {
        let payload = request_payload.data(using: .utf8)
        var response_string = Direct_esponse()
        var request = URLRequest(url: URL(string: request_enpoint)!)
        var req_response: String = ""
        let appgroup:String = "group.com.paymentasia.papayswift"
        let sem = DispatchSemaphore.init(value: 0)
//        print(request_enpoint)
        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) in
            defer{sem.signal()}
            guard error == nil else { print(error!.localizedDescription); return}
            guard let data = data else {print("Empty data"); return}
            
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            print(json)
            let json_response = json?["response"] as? NSDictionary
            req_response = json_response?["code"] as! String
            if(json_response?["code"] as! String == "200"){
//                    print(json_response?["code"] as! String)
                let json_payload = json?["payload"] as?NSDictionary
                
                switch self.request_enpoint {
                    case "https://gateway.pa-sys.com/papay/information":
                        print("info page")
                        UserDefaults(suiteName: appgroup)?.set(json_payload?["amount"] as! String, forKey: "amount")
                        UserDefaults(suiteName: appgroup)?.set(json_payload?["last_transaction_time"] as! Int, forKey: "last_transaction_time")
                        UserDefaults(suiteName: appgroup)?.set(json_payload?["merchant_store_address"] as! String, forKey: "merchant_store_address")
                        UserDefaults(suiteName: appgroup)?.set(json_payload?["name"] as! String, forKey: "merchant_name")
                        UserDefaults(suiteName: appgroup)?.set(json_payload?["terminal_id"] as! String, forKey: "terminal_id")
                    case "https://gateway.pa-sys.com/papay/sign-in":
                        print(json_payload?["token"]!)
                        UserDefaults.standard.set(json_payload?["qrcode"] as! String, forKey: "qrcode")
                        UserDefaults.standard.set(json_payload?["signature_secret"] as! String, forKey: "signature_secret")
                        UserDefaults.standard.set(json_payload?["token"] as! String, forKey: "token")
                        UserDefaults(suiteName: appgroup)?.set(json_payload?["qrcode"] as! String, forKey: "qrcode")
                        UserDefaults(suiteName: appgroup)?.set(json_payload?["signature_secret"] as! String, forKey: "signature_secret")
                        UserDefaults(suiteName: appgroup)?.set(json_payload?["token"] as! String, forKey: "token")
                    default:
                        print("no one")
                }
//
            } else {
//                req_response = json_response?["code"] as! String
                UserDefaults(suiteName: appgroup)?.removeObject(forKey: "qrcode")
                UserDefaults(suiteName: appgroup)?.removeObject(forKey: "signature_secret")
                UserDefaults(suiteName: appgroup)?.removeObject(forKey: "token")
                UserDefaults.standard.removeObject(forKey: "qrcode")
                UserDefaults.standard.removeObject(forKey: "signature_secret")
                UserDefaults.standard.removeObject(forKey: "token")
            }
            
        }).resume()
        sem.wait()
        
        return req_response
    }
    func connect_back(withRequest request: URLRequest, withCompletion completion: @escaping (String?, Error?)->Void){
        let payload = request_payload.data(using: .utf8)
        var request = URLRequest(url: URL(string: request_enpoint)!)
        request.httpMethod = "POST"
        request.httpBody = payload
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                completion(nil, error)
                return
            }
            else if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {completion(nil, nil);return}
//                    guard let details = json["response"]["code"] as? String else {completion(nil, nil); return}
                    completion(json as AnyObject as? String, nil)
                }
                catch {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func taketotherplace() -> Alert {
        let set_alert = Alert(
            title: Text("Testing"), message: Text("Message"), dismissButton: .default(Text("OK"), action: {})
        )
        return set_alert
        
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
