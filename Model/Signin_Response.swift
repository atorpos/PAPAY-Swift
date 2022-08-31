//
//  Signin_Response.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 7/26/22.
//

import Foundation

struct Signin_Response:Codable {
    let request: Request_Signin
    let response: Response_Signin
    let payload: Payload_Signin
}
struct Payload_Signin: Codable {
    let merchant_name: String
    let provider: [String]
    let qrcode: String
    let screen_saver: [String]
    let signature_secert: String
    let tnc: Int
    let token: String
}
struct Provider:Codable {
    
}

struct Response_Signin:Codable {
    let code: String
    let message: String
    let time: String
}
struct Request_Signin:Codable {
    let id: String?
    let time: String?
}
