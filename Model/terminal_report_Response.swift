//
//  terminal_report_Response.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 3/28/23.
//

import Foundation

struct Terminal_Report_Response:Codable {
    let request: Request_trp
    let response: Response_trp
    let payload: [String?]
    
}
struct Request_trp:Codable {
    let id: String?
    let time: String?
}
struct Response_trp:Codable {
    let code: String
    let message: String
    let time: String
}
