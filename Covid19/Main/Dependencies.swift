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
        
        //Managers
        Dependencies.container.register(EventManager.self) { _ in EventsManager()}.inObjectScope(.container)
        
        //Services
        Dependencies.container.register(VideosRepository.self) { _ in NetworkService()}
        Dependencies.container.register(NewsRepository.self) { _ in NetworkService()}
        Dependencies.container.register(CasesRepository.self) { _ in NetworkService()}
        Dependencies.container.register(Browser.self) { _ in SafariService()}
        Dependencies.container.register(ImageDownloader.self) { _ in ImageDownloaderService()}
        Dependencies.container.register(Logger.self) { _ in LoggerService()}
        Dependencies.container.register(UserdataValidator.self) { _ in FirebaseUserdata()}
        Dependencies.container.register(UserdataSaver.self) { _ in FirebaseUserdata()}
        Dependencies.container.register(GoogleSignIn.self) { _ in FirebaseUserdata()}
        Dependencies.container.register(KeychainUserdata.self) { _ in KeychainUserdataService()}
        
        //UI
        Dependencies.container.register(UserFieldsValidator.self) { _ in UserFieldsChecker()}
        Dependencies.container.register(UIstyle.self) { _ in StyleProvider()}
        
        //Text
        Dependencies.container.register(TextProcessor.self) { _ in TextProcessorService()}
    }
}

