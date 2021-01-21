//
//  DependencyInjections.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 14.01.21.
//

import Foundation
import Swinject

class Dependencies {

    static var container: Container!
    
    static func registerDependencies () {
        Dependencies.container.register(UserFieldsValidator.self) { _ in UserFieldsChecker ()}
        Dependencies.container.register(UIstyle.self, name: "Light") { _ in LoginStylerLight()}
        Dependencies.container.register(UIstyle.self, name: "Dark") { _ in LoginStylerDark()}
        Dependencies.container.register(EventManager.self) { _ in EventsManager()}.inObjectScope(.container)
    }
}
