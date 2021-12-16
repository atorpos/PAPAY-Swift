//
//  transaction-model.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/16/21.
//

import Foundation

public struct TransactionModel {
    let url: String
    var endpoint: String
    var token: String
    var secret: String
    var req_response: String?
    
    func getlist() ->String {
        
        return "1TEST"
        
    }
    
    func acqureqr() ->String {
        
        return "TEST"
    }
}
