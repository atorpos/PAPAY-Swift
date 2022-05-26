//
//  ui-model.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 9/27/21.
//

import Foundation
import UIKit

public struct UiModel {
//    var screen_side: String
    let screen_width: Float     =   Float(UIScreen.main.bounds.width)
    let screen_height: Float    =   Float(UIScreen.main.bounds.height)
    
    func windowsafewindow() {
        if #available(iOS 13.0, *){
            
        }
    }
    
}

class GetSafeView: UIView {
//    let mainwindow = UIApplication.shared.windows.first
//    let topPadding  = mainwindow?.safeAreaInsets.top
//    let bottomPadding = mainwindow?.safeAreaInsets.bottom
}


