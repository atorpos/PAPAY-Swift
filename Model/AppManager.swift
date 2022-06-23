//
//  AppManager.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 6/6/22.
//

import Foundation
import Combine

struct AppManager {
    
    static let Authenticated = PassthroughSubject<Bool, Never>()
    
    static func IsAuthenticated() -> Bool {
        return UserDefaults.standard.string(forKey: "token") != nil
    }
    
}
