//
//  Info_Response.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 7/26/22.
//

import Foundation

struct InfoResponse:Codable {
    let request: Request_Info
    let response: Response_Info
    let payload: Payload_Info
}
struct Payload_Info: Codable {
    var amount: String
    var last_transaction_time: StringOrDouble?
    var merchant_id: String
    var merchant_store_address: String
    var merchant_store_tel: String
    var name: String
    var screen_saver: [String]
    var terminal_id: String
    
//    enum type of string or double
    enum StringOrDouble: Codable {
        
        case string(String)
        case double(Double)
        
        init(from decoder: Decoder) throws {
            if let double = try? decoder.singleValueContainer().decode(Double.self) {
                self = .double(double)
                return
            }
            if let string = try? decoder.singleValueContainer().decode(String.self) {
                self = .string(string)
                return
            }
            throw Error.couldNotFindStringOrDouble
        }
        enum Error: Swift.Error {
            case couldNotFindStringOrDouble
        }
    }
//    
}
struct Screensaver_Info: Codable {
    
}

struct Response_Info:Codable {
    let code: String
    let message: String
    let time: String
}
struct Request_Info:Codable {
    let id: String?
    let time: String?
}
