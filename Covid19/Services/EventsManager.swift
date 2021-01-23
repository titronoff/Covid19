//
//  EventManager.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 21.01.21.
//

import Foundation

protocol EventManager {
    func subscribe(listener: EventListener)
    func notify()
}

protocol EventListener: NSObjectProtocol {
    func update()
}

enum EventType {
    case login
    case logout
}

class EventsManager: EventManager {
    
    private var listeners = [EventListener]()
    
    func subscribe (listener: EventListener) {
        listeners.append(listener)
    }
    
    func unsubscribe (listener: EventListener){
        if let indexx = listeners.firstIndex(where: { (findListener) -> Bool in
            findListener === listener
        }) {
            listeners.remove(at: indexx)
        }
    }
    
    func notify () {
        listeners.forEach { listener in
            listener.update()
        }
    }
}

