//
//  Request_Response.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 8/15/22.
//

import Foundation

struct RequestResponse:Codable {
    let request: Request_request
    let response: Response_request
    let payload: Payload_request
}

struct Request_request:Codable {
    let id: String?
    let time: String?
}
struct Response_request:Codable {
    let code: String
    let message: String
    let time: String
}
struct Payload_request:Codable {
    let type: String?
    let provider: String?
    let request_reference: String?
    let merchant_reference: String?
    let amount: StringOrDouble?
    let currency: String
    let status: String?
    let remark: String?
    let merchant_store_address: String?
    let transaction_status: String?
    let created_time: Int?
    let completed_time:Int?
    let big_pic_url:String?
    let pic_url:String?
    let qr_code_string: String?
    
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


