//
//  keypadView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 11/18/21.
//

import SwiftUI

var calculatorText:String = ""

struct keypadView: View {
    
    @State var numberlabel = "0";
    
    var body: some View {
//        let getkeypadno = CalculateModel()
        GeometryReader { geometer in
            VStack(alignment: .center, spacing: 0) {
                //display pad view
                Text("\(calculatorText)")
                Spacer(minLength: 48)
                HStack(alignment: .center, spacing: 0){
                    Button(action: {
                        addnumber(_number: "1")
                               }) {
                                   Text("1")
                                       .frame(width: geometer.size.width/3, height: 130)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                               }
                    Button(action: {
                        addnumber(_number: "2")
                               }) {
                                   Text("2")
                                       .frame(width: geometer.size.width/3, height: 130)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                               }
                    Button(action: {
                               addnumber(_number: "3")
                               }) {
                                   Text("3")
                                       .frame(width: geometer.size.width/3, height: 130)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                               }
                }
                HStack(alignment: .center, spacing: 0){
                    Button(action: {
                               addnumber(_number: "4")
                               }) {
                                   Text("4")
                                       .frame(width: geometer.size.width/3, height: 130)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                               }
                    Button(action: {
                               addnumber(_number: "5")
                               }) {
                                   Text("5")
                                       .frame(width: geometer.size.width/3, height: 130)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                               }
                    Button(action: {
                               addnumber(_number: "6")
                               }) {
                                   Text("6")
                                       .frame(width: geometer.size.width/3, height: 130)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                               }
                }
                HStack(alignment: .center, spacing: 0){
                    Button(action: {
                               addnumber(_number: "7")
                               }) {
                                   Text("7")
                                       .frame(width: geometer.size.width/3, height: 130)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                                       .clipShape(Circle())
                               }
                    Button(action: {
                               addnumber(_number: "8")
                               }) {
                                   Text("8")
                                       .frame(width: geometer.size.width/3, height: 130)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                                       .clipShape(Circle())
                               }
                    Button(action: {
                               addnumber(_number: "9")
                               }) {
                                   Text("9")
                                       .frame(width: geometer.size.width/3, height: 130)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                                       .clipShape(Circle())
                               }
                }
                HStack(alignment: .center, spacing: 0){
                    Button(action: {
                               print("=")
                               }) {
                                   Text("+")
                                       .frame(width: geometer.size.width/3, height: 120)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                                       .clipShape(Circle())
                               }
                    Button(action: {
                               addnumber(_number: "0")
                               }) {
                                   Text("0")
                                       .frame(width: geometer.size.width/3, height: 120)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                                       .clipShape(Circle())
                               }
                    Button(action: {
                               delnumber()
                               }) {
                                   Text("Del")
                                       .frame(width: geometer.size.width/3, height: 120)
                                       .foregroundColor(Color.black)
                                       .background(Color.clear)
                                       .border(Color.gray, width: 1)
                                       .clipShape(Circle())
                               }
                }
                
            }
            
        }
        
    }
}

struct keypadView_Previews: PreviewProvider {
    static var previews: some View {
        keypadView()
    }
}

private func addnumber(_number:String) ->Void {
    calculatorText += _number
    if(calculatorText.count > 3) {
        calculatorText = calculatorText.replacingOccurrences(of: ".", with: "")
    }
    if(calculatorText.count > 2) {
        calculatorText.insert(".", at: calculatorText.index(calculatorText.endIndex, offsetBy: -2))
    }
    if(calculatorText.count == 1) {
        calculatorText = "0.0" + calculatorText
    }
    
    if(calculatorText.prefix(3) == "00."){
        calculatorText.remove(at: calculatorText.index(calculatorText.startIndex, offsetBy: 1))
    }
//    numberlabel = calculatorText
    print(calculatorText)
}

func accesselement(name: String, element: UILabel) {
//    let textlabel = "text label view"
    
    element.text = name
}


private func delnumber() ->Void {
    if(calculatorText.count > 0 ) {
        calculatorText.remove(at: calculatorText.index(before: calculatorText.endIndex))
    }
    if(calculatorText.last == ".") {
        calculatorText = calculatorText.replacingOccurrences(of: ".", with: "")
    }
    
    print(calculatorText)
    
}

public func showvalue(number: String) ->Text {
    
    return Text(number)
}
