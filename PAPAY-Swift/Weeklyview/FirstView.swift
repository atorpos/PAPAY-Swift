//
//  FirstView.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 9/16/21.
//

import SwiftUI
import Charts

struct FirstView: View {
    @State private var showingAlert = false
    @State private var maxValue = 800.0
    @State private var minValue = 0.0
    let gradient = Gradient(colors: [.green, .yellow, .red, .blue])
    let weekDays = Calendar.current.shortWeekdaySymbols
    let sales = [987,4866,738,893,423,523,6788]
    
    var body: some View {
        let _dimension = UiModel()
        let _window_width: Float = _dimension.screen_width
        
        NavigationView {
            VStack {
//                Text(String(format: "%.1f",_window_width))
                Text(String(format: "%.1f", maxValue))
                if #available(iOS 16.0, *) {
                    Gauge(value: 424, in: minValue...maxValue){
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    } currentValueLabel: {
                        Text("\(Int(424))")
                            .foregroundColor(Color.green)
                    }  minimumValueLabel: {
                        Text("\(Int(minValue))")
                            .foregroundColor(Color.green)
                    } maximumValueLabel: {
                        Text("\(Int(maxValue))")
                    }
                    .gaugeStyle(.accessoryCircular)
                    .tint(gradient)
                    Chart {
                        ForEach(weekDays.indices, id: \.self) {
                            index in
                            BarMark(
                                x: .value("Day", weekDays[index]),
                                y: .value("Sales", sales[index])
                            )
                            .foregroundStyle(by: .value("Day", weekDays[index]))
                            .annotation{
                                Text("$\(sales[index])")
                            }
                            AreaMark(
                                x: .value("Day", weekDays[index]),
                                y: .value("Sales", sales[index])
                            )
                            .opacity(0.5)
                            
                        }
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
                .navigationTitle("Report")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAlert = true
                        }) {
                            Image(systemName: "info.circle")
                                .scaledToFit()
                            
                        }
                        Button(action: {
                            actionsheet()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                        }
                    }
                }
        } .onAppear{
            let run_report_model = terminal_report()
            run_report_model.get_report()
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK", role: .cancel){ }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}

func actionsheet() {
    guard let urlShare = URL(string: "https://www.paymentasia.com") else {return}
    let activeityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(activeityVC, animated: true, completion: nil)
}
