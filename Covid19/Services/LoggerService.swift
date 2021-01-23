//
//  LoggerService.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 23.01.21.
//

import Foundation

protocol Logger {
    func updateLog()
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
}
