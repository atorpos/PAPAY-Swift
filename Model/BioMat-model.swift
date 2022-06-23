//
//  BioMat-model.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 6/23/22.
//

import Foundation
import LocalAuthentication

class biomatmodel {

    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "To unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    print("is success")
                } else {
                    print("not success")
                }
            }
        } else {
            print("no biometrics")
        }
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
            
    }
        
}

