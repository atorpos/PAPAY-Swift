//
//  widgetLiveActivity.swift
//  widget
//
//  Created by Oskar Wong on 2/22/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct widgetAttributes: ActivityAttributes {
    public typealias WidState = ContentState
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct widgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: widgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Hello this is me").font(.headline)
                        HStack {
                            Text("$0")
                            VStack {
                                ProgressView("Currently earn $400", value: 400, total: 800)
                            }
//                            Image(systemName: "box.truck.badge.clock.fill").foregroundColor(.blue)
//                            VStack {
//                                RoundedRectangle(cornerRadius: 5)
//                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
//                                    .frame(height:6)
//                            }
//                            Image(systemName: "house.fill").foregroundColor(.green)
                        }
                    }.padding(.trailing, 25)
                    VStack {
                        Text("$800").font(.title).bold()
                        Text("Your daily goal").font(.caption).foregroundColor(.secondary)
                    }
                    
                }.padding(5)
//                Text("Your daily goal").font(.caption).foregroundColor(.secondary)
            }.padding(15)
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
                HStack{
                    Image(systemName: "dollarsign.circle")
                    Text("Amount: ")
                }
            } compactTrailing: {
                Text("$800.00")
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}


struct widgetLiveActivity_Previews: PreviewProvider {
    static let attributes = widgetAttributes(name: "Me")
    static let contentState = widgetAttributes.ContentState(value: 3)

    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expanded")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
