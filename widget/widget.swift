//
//  widget.swift
//  widget
//
//  Created by Oskar Wong on 6/16/22.
//

import WidgetKit
import SwiftUI
import Intents
import Foundation
import CoreImage.CIFilterBuiltins

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
}

struct widgetEntryView : View {
    var entry: Provider.Entry
    let appgroup:String = "group.com.paymentasia.papayswift"
    
    var body: some View {
//        Text(entry.date, style: .time)
        VStack(spacing:8){
            HStack {
                Text(UserDefaults(suiteName: appgroup)?.string(forKey: "merchant_name") ?? "No Name")
//                GeometryReader{ geo in
//                    Image(uiImage: generateQRCode(from:gettoken()))
//                        .resizable()
//                        .scaledToFit()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: geo.size.width*0.4)
//                        .frame(width: geo.size.width, height: geo.size.height)
//                }
            }
            
            Text(getaccinfo())
                .foregroundColor(Color(.white))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ContainerRelativeShape().fill(Color(.blue).opacity(0.8)))
        
       
//        Text()
    }
    
    func gettoken() -> String {
//        let appgroup:String = "group.com.paymentasia.papayswift"
        let testStr: String! = UserDefaults(suiteName: appgroup)?.string(forKey: "qrcode") ?? ""
        return testStr ?? "no token"
    }
    
    private func getaccinfo()->String {
//        let appgroup:String = "group.com.paymentasia.papayswift"
//        let req_token: String! = UserDefaults(suiteName: appgroup)?.string(forKey: "token") ?? ""
        let connect_model = PapayInfo()
        return connect_model.infopapay()
        
    }
    
    private func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter  =   CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}


@main
struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
        widgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
