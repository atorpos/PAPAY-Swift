//
//  Server_Response.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 7/26/22.
//

import Foundation

struct TransactionsResponse:Codable {
    let request: Request_transaction
    let response: Response_transaction
    let payload: Payload_transaction
}
struct Payload_transaction: Codable {
    let transactions: [Transactions]
}
struct Transactions: Codable {
    let request_reference: String
    let merchant_reference: String
    let provider_reference: String?
    let type: String
    let status: String
    let order_currency: String
    let order_amount: String
    let provider: String
    let created_time: String
    let updated_time: String
}
struct Response_transaction:Codable {
    let code: String
    let message: String
    let time: String
}
struct Request_transaction:Codable {
    let id: String?
    let time: String?
}
