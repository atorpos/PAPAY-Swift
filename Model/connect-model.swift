//
//  connect-model.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 8/31/21.
//

import Foundation

public struct ConnectModel {
    let url: String //let is static variable
    var endpoint: String
    var token: String
    var secret: String
    var req_response: String?
    
    func getinfo() -> String {
        let date = Date()
        let dateFormatter = DateFormatter();
        dateFormatter.string(from: date)
        
//        let ran_number = Int.random(in: 100000..<99999999)
        
        let parameters: [String : Any] = [
            "merchant_id":"2018-PAPAY",
            "terminal_id": 1091,
            "password": "demo1234"
        ]
        
        var connect_url: String
        
        //login the system
        var end_point_result: String
        if (UserDefaults.standard.object(forKey: "token") != nil) {
            connect_url = url+PAPAYConfig().information_ep
            end_point_result = get_info(url: connect_url, token: UserDefaults.standard.object(forKey: "token") as! String)
        } else {
            connect_url =   url+endpoint
            end_point_result = login_connect(url: connect_url, token: "1349348394839834", secret: "93783437643763473", post_data: parameters)
        }
        
        
        return String(end_point_result)
//        return String(end_point_result+" "+String(ran_number))
    }
    func gettabbar() -> String {
        return "first tab"
    }
    
    static func getPostString(params:[String:Any]) -> String
        {
            var data = [String]()
            for(key, value) in params
            {
                data.append(key + "=\(value)")
            }
            return data.map { String($0) }.joined(separator: "&")
        }
    static func convertToDictionary(text: String)->[String: Any]? {
        if let data = text.data(using: .utf8){
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    private func login_connect(url:String, token:String, secret:String, post_data:[String: Any])->String {
        
        let postString = ConnectModel.getPostString(params: post_data)
        var return_var: String!
        let sem = DispatchSemaphore.init(value: 0)
        guard let live_url = URL(string: url) else {
            return "error"
        }
        
        var request = URLRequest(url: live_url)
        request.httpMethod = "POST"
//        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: .utf8)
//        request.httpBody = try? JSONSerialization.data(withJSONObject: post_data, options: [])
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request){ (data, response, error)->Void in
            defer {sem.signal()}
            guard error == nil else { print(error!.localizedDescription); return}
            guard let data = data else {print("Empty data"); return}

            if let str = String(data: data, encoding: .utf8){
                
                return_var = str
            }
        }
        task.resume()
        sem.wait()
        
        let mixuptext   =   ConnectModel.convertToDictionary(text: return_var)
        let payload:[String:Any] = mixuptext?["payload"] as! [String : Any]
        let token: String = (payload["token"] as? String)!
        UserDefaults.standard.set(token, forKey: "token")
        
        return token
    }
    
    private func get_info(url:String, token:String)->String {
        var return_val:String
        let post_token: [String: Any] = [
            "token":token
        ]
        let postString = ConnectModel.getPostString(params: post_token)
        
        var return_var: String!
        let sem = DispatchSemaphore.init(value: 0)
        guard let live_url = URL(string: url) else {
            return "error"
        }
        
        var request = URLRequest(url: live_url)
        request.httpMethod = "POST"
//        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: .utf8)
//        request.httpBody = try? JSONSerialization.data(withJSONObject: post_data, options: [])
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request){ (data, response, error)->Void in
            defer {sem.signal()}
            guard error == nil else { print(error!.localizedDescription); return}
            guard let data = data else {print("Empty data"); return}

            if let str = String(data: data, encoding: .utf8){
                
                return_var = str
            }
        }
        task.resume()
        sem.wait()
        
        let mixuptext   =   ConnectModel.convertToDictionary(text: return_var)
        let api_response:[String:Any]    =   mixuptext?["response"] as! [String: Any]
        let response_code: String = api_response["code"]  as Any as! String
        print(response_code)
        if(api_response["code"] as! String == "200"){
            let payload:[String:Any] = mixuptext?["payload"] as! [String : Any]
            let token: String = (payload["terminal_id"] as? String)!
            return_val = token+" testing"
        } else {
            
            UserDefaults.standard.removeObject(forKey: "token")
            return "not logged"
        }
        
        return return_val
    }
}



struct ConnectModel2 {
    
    let url: String //let is static variable
    var token: String
    var secret: String
    
    init(url: String, token: String, secret: String){
        self.url = url
        self.token = token
        self.secret = secret
    }
    
    func getinfo() -> String {
        return "testing"
    }
    func gettabbar() -> String {
        return "first tab"
    }
    
    private func connect() {
        
    }

}
