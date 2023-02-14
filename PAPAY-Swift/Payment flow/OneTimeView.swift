//
//  OneTimeView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 9/1/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct OneTimeView: View {
    let onetimecode:String
    let request_valeu:String
    let appgroup:String = "group.com.paymentasia.papayswift"
    @State var qrcode_string:String
    @State var request_reference: String
    
    @State var timerRemaining = 0
    @State var transaction_status = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("\(onetimecode) amount \(request_valeu) qrcode \(qrcode_string) reference \(request_reference)")
        Image(uiImage: generateQRCode(from: "\(qrcode_string)"))
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
            .onAppear(perform: getonetimeqr)
    }
    
    func getonetimeqr() {
        let connect_model = PapayRequest()
        let decoder = JSONDecoder()
        var responsecode: Int = 400
        connect_model.request_amount = request_valeu
        var submit_provider:String?
        switch onetimecode {
            case "ALIPAYOFFLINE":
                submit_provider = "ALIPAY"
                break
            case "WECHATOFFLINE":
                submit_provider = "WECHAT"
                break
            case "CUPOFFLINE":
                submit_provider = "CUP"
                break
            case "ATOMEOFFLINE":
                submit_provider = "ATOME"
                break
            case "GLOBALCASH":
                submit_provider = "FPS"
                break
            default:
                submit_provider = "ALIPAY"
        }
        let response_values = connect_model.onetimerequest(requestChannel: submit_provider!)
        print(response_values)
        do {
            let ser_response = try decoder.decode(RequestResponse.self, from: Data(response_values.utf8))
            responsecode = Int(ser_response.response.code) ?? 400
            qrcode_string = ser_response.payload.qr_code_string ?? "nil qrcode"
            request_reference = ser_response.payload.request_reference ?? "nil reference"
            print(qrcode_string)
        } catch {
            print(String(describing: error))
        }
    }
    
//    func generateQRCode(from string:String)->UIImage {
//        let context = CIContext()
//        let filter = CIFilter.qrCodeGenerator()
//        filter.message = Data(string.utf8)
//
//        if let outputImage = filter.outputImage {
//            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
//                return UIImage(cgImage: cgimg)
//            }
//        }
//        return UIImage(systemName: "xmark.circle") ?? UIImage()
//    }
    private func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter  =   CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        let transform = CGAffineTransform(scaleX: 5, y: 5)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage?.transformed(by: transform) {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct OneTimeView_Previews: PreviewProvider {
    static var previews: some View {
        OneTimeView(onetimecode: "", request_valeu: "", qrcode_string: "", request_reference: "")
    }
}
