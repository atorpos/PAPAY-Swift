//
//  camViewModel.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 7/18/22.
//

import Foundation
import AVFoundation
import CodeScanner

class CamViewModel: ObservableObject {
    
    let scanInterval: Double = 1.0
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    @Published var torchIsOn: Bool = false
    
    @Published var lastQrCode: String = "QR Code goes here"
    
    func onFoundQrCode (_ code: String) {
        self.lastQrCode = code
    }
}
