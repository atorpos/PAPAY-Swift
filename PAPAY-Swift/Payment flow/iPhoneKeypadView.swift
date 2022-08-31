//
//  iPhoneKeypadView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 7/14/22.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "C"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    case submittopay = "Process"
    
    var buttonColor: Color {
            switch self {
            case .add, .subtract, .mutliply, .divide, .equal:
                return .orange
            case .clear, .negative, .percent:
                return Color(.lightGray)
            case .submittopay:
//                    return Color(UIColor(red: 0.34, green: 0.18, blue: 1, alpha: 1))
                    return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
            default:
                return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
            }
        }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct iPhoneKeypadView: View {
    
    @State var value = "0.00"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none

    let buttons: [[CalcButton]] = [
//        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine],
        [.four, .five, .six],
        [.one, .two, .three],
        [.clear, .zero, .decimal],
//        [.submittopay]
    ]
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                // Text display
                HStack {
                    Image(systemName: "text.bubble")
                        .foregroundColor(.black)
                        .imageScale(.large)
                    Spacer()
                    Text("$")
                        .font(.system(size: 40, weight: .ultraLight))
                        .foregroundColor(.black)
                    Text(value)
//                        .bold()
                        .font(.system(size: 80, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding()

                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 36, weight: .light, design:.rounded))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
                if(value == "0.00") {
                    Button(action: {self.didTap(button: .submittopay)}, label: {
                        Text("Input the Value")
                            .font(.system(size: 24, weight: .light))
                            .frame(
                                width: self.buttonWidth(item: .submittopay),
                                height: self.buttonHeight()
                            )
                            .background(Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)))
                            .foregroundColor(.white)
                            .cornerRadius(self.buttonWidth(item: .submittopay)/2)
                    })
                } else {
                    NavigationLink(destination: ScannerView(submitvalue: value).navigationBarBackButtonHidden(true)) {
                            ButtonView()
                        }
                }
                
            }
        }
    }
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .mutliply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }

            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0.00"
        case .negative, .percent:
            break
        case .decimal:
                if self.value == "0.00" {
                    value = "0."
                } else if self.value == "0." {
                    value = "0."
                } else {
                    self.value = "\(self.value)."
                }
            break
        case .submittopay:
            break
        default:
            let number = button.rawValue
            if self.value == "0.00" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
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

struct ButtonView:View {
    var body: some View {
        Text("Process")
            .font(.system(size: 36, weight: .light))
            .frame(
                width: self.buttonWidth(item: .submittopay),
                height: self.buttonHeight()
            )
            .background(Color(UIColor(red: 0.34, green: 0.18, blue: 1, alpha: 1)))
            .foregroundColor(.white)
            .cornerRadius(self.buttonWidth(item: .submittopay))
    
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

struct iPhoneKeypadView_Previews: PreviewProvider {
    static var previews: some View {
        iPhoneKeypadView()
    }
}
