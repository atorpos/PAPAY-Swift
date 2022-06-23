//
//  ContentRepository.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 6/17/22.
//

import Foundation
import Combine

extension FileManager {
    static func sharedContainerURL() -> URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.paymentasia.papayswift")!
    }
    
}
