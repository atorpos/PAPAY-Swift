//
//  calculate-model.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/25/21.
//

import Foundation

public struct CalculateModel {
//    var storevalue:String
    
    func getkeypad(from string: String)->String {
        var storevalue:String = "0"
       
        storevalue = storevalue+string
        let updatevlaue: String = storevalue
        
        return updatevlaue
    }
    
}

public struct Person {
    
    var testingString: String {
        willSet {
            output_UI(msg: "I'm changing from \(testingString) to \(newValue)")
        }
        
        didSet {
            output_UI(msg: "I just changed from \(oldValue) to \(testingString)")
        }
    }
    
    func output_UI(msg: String) {
        print(msg)
    }
    
}

//public struct AddValue{
//    var inputvalue: Int
//    
//    var sumupvalue: int {
//        get {
//            return inputvalue
//        }
//    }
//}
