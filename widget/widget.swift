//
//  widget.swift
//  widget
//
//  Created by Oskar Wong on 5/26/21.
//

import WidgetKit
import SwiftUI
import Intents
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
//    let _model = ConnectModel(url: PAPAYConfig().production_url, endpoint: PAPAYConfig().login_ep, token: "98765r6dtghud83", secret: "86t6ygyufeiehfuhfe")

    var body: some View {
//        Text(entry.date, style: .time)
        Text("fucl you")
//        Text(_model.getinfo())
//        Image(uiImage: generateQRCode(from: _model.getinfo()))
//            .resizable()
//            .scaledToFit()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 50, height: 50)
        
    }
    
}
func generateQRCode(from string: String) -> UIImage {
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

@main
struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
        widgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
