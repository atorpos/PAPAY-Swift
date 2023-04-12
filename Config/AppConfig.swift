//
//  AppConfig.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 9/14/21.
//

import Foundation

struct PAPAYConfig {
    let production_url          =   "https://gateway.pa-sys.com"
    let production_merchant_url =   "https://merchant.pa-sys.com"
    let login_ep                =   "/papay/sign-in"
    let transaction_ep          =   "/papay/transactions"
    let information_ep          =   "/papay/information"
    let changepw_ep             =   "/papay/change-password"
    let request_ep              =   "/papay/qrcode-recognition"
    let query_ep                =   "/papay/query"
    let onetime_ep              =   "/papay/one-time-qrcode"
    let promo_ep                =   "https://merchant.pa-sys.com/papay/promotion/"
    let heartbeat_ep            =   "/papay/heartbeat"
    let terminal_report_ep      =   "/papay/terminal-report"
}
