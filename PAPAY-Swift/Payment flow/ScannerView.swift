//
//  ScannerView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 6/29/22.
//

import SwiftUI
import Vision
import AVFoundation
import CodeScanner

struct ScannerView: View {
    let submitvalue:String
    @State private var isShowingScanner = false
    @State private var scannedCode: String?
    @State private var isShowingOnetime = false
    @State private var onetimeCode: String?
//    @ObservedObject var viewModel = CamViewModel()
    
    var body: some View {
        let appgroup:String = "group.com.paymentasia.papayswift"
        let channels:[String] = UserDefaults(suiteName: appgroup)?.stringArray(forKey: "channels") ?? [String]()
        if let code = scannedCode {
            NavigationLink("Processing", destination: ProcessingView(theqrcode: code, theamount:submitvalue).navigationBarBackButtonHidden(true), isActive: .constant(true)).hidden()
        }
        if let onetimetype = onetimeCode {
            NavigationLink("One time Code", destination: OneTimeView(onetimecode: onetimetype, request_valeu: submitvalue, qrcode_string: "no qrcode", request_reference: "no reference").navigationBarBackButtonHidden(true), isActive: .constant(true)).hidden()
        }
        ZStack {
            CodeScannerView(codeTypes:[.qr]) { response in
                if case let .success(result) = response {
                    scannedCode = result.string
//                    print(scannedCode)
                    isShowingScanner = false
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 10, content: {
                Text("$ \(Double(submitvalue)!, specifier: "%.2f")")
                    .font(.system(size: 36, weight: .light))
                    .frame(
                        width: (UIScreen.main.bounds.width - (4*12)),
                        height: (UIScreen.main.bounds.width - (5*12)) / 4
                    )
                    .background(Color(red: 1, green: 1, blue: 1, opacity: 0.9))
                    .foregroundColor(.gray)
                    .cornerRadius((UIScreen.main.bounds.width - (4*12))/2)
                    .padding(.top)
                Spacer()
                HStack(alignment: .center, spacing: 2) {
                    Spacer()
                    ForEach(0 ..< channels.count, id:\.self) { value in
                        ZStack {
                            Circle()
                                .fill(Color(red: 1, green: 1, blue: 1, opacity: 0.9))
                                .frame(
                                    width: (UIScreen.main.bounds.width - (6*12)) / 7, height: (UIScreen.main.bounds.width - (6*12)) / 7
                                )
                            Button(action: {
                                print("button press \(channels[value])")
                                onetimeCode = channels[value]
                                isShowingOnetime = true
//                                NavigationLink {
//                                    OneTimeView()
//                                } label: {
//                                    Text("\(channels[value])")
//                                }
                                
                            }) {
                                Image(channels[value])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaledToFit()
                                    .frame(
                                        width: (UIScreen.main.bounds.width - (6*12)) / 6 * 0.5 , height: (UIScreen.main.bounds.width - (6*12)) / 6 * 0.5
                                    )
                            }
                        }
                        .padding(.trailing, 10)
                    }
                    Spacer()
                }
                .padding(.bottom)
            })
            .edgesIgnoringSafeArea(.all)
            
        }
        
    }
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .percent {
            return ((UIScreen.main.bounds.width - (4*12)) / 3) * 2
        } else if item == .submittopay {
            return ((UIScreen.main.bounds.width - (4*12)))
        }
        return (UIScreen.main.bounds.width - (5*12)) / 3
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView(submitvalue: "0.00")
    }
}
