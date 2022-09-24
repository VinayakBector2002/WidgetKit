//
//  CalenderWidget.swift
//  CalenderWidget
//
//  Created by Vinayak Bector on 2022-09-24.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (DayEntry) -> ()) {
        let entry = DayEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of 7 entries 24hrs apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct CalenderWidgetEntryView : View {
    var entry: DayEntry
    var config: MonthConfig
    
    init(entry: DayEntry) {
        self.entry = entry
        self.config = MonthConfig(backgroundcolor: .gray, emojiText:"🇨🇦", textColor:.black)
    }
    var body: some View {
        let TextColor : Color = config.textColor
        
        ZStack{
            ContainerRelativeShape()
                .fill(config.backgroundcolor.gradient)
            VStack{
                HStack(spacing:4){
                    Text(config.emojiText)
                        .font(.title)
                    Text(entry.date.weekdayDisplayFormat)
                        .font(.title3)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                        .foregroundColor(TextColor.opacity(0.6))
                    Spacer()
                }
                Text(entry.date.dayDisplayFormat)
                    .font(.system(size:80,weight: .heavy))
                    .foregroundColor(TextColor.opacity(0.6))
            }
            .padding()
        }
    }
}

@main
struct CalenderWidget: Widget {
    let kind: String = "CalenderWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CalenderWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Calender Widget")
        .description("To display Day and Date")
        .supportedFamilies([.systemSmall])
    }
}

struct CalenderWidget_Previews: PreviewProvider {
    static var previews: some View {
        CalenderWidgetEntryView(entry: DayEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

extension Date {
    var weekdayDisplayFormat : String {
        self.formatted(.dateTime.weekday(.wide))
    }
    var dayDisplayFormat : String {
        self.formatted(.dateTime.day())
    }
}





