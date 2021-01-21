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

protocol EventListener {
    func update()
}



enum EventType {
    case loin
    case logout
}



class EventsManager: EventManager {
    
    private var listeners = [EventListener]()
    
    func subscribe (listener: EventListener) {
        listeners.append(listener)
    }
    
    func notify () {
        listeners.forEach { listener in
            listener.update()
        }
    }
}

class Loger: EventListener {
    init() {
        Dependencies.container.resolve(EventManager.self)!.subscribe(listener: self)
    }
    
    func update() {
        print("Logout event")
    }
}
