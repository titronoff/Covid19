//
//  LoggerService.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 23.01.21.
//

import Foundation
import FirebaseAnalytics

protocol Logger {
    func updateLog()
}
protocol FirebaseLogger {
    func logEventToFirebase(event: EventType)
}

class LoggerService: NSObject, EventListener, Logger {
    override init() {
        super.init()
        Dependencies.container.resolve(EventManager.self)!.subscribe(listener: self)
    }
    
    func update() {
        updateLog()
    }
    
    func updateLog() {
        print("Logout event")
    }
    
    func logEventToFirebase(event: EventType) {
        let title = "test event"
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "id-\(title)",
          AnalyticsParameterItemName: title,
          AnalyticsParameterContentType: "cont"
          ])
    }
}

