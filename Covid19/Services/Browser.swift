//
//  DataManagers.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/21/20.
//

import UIKit
import SafariServices

// MARK: Safari browser
class Browser {
    class func OpenUrl(_ url: String?, _ homeVC: UIViewController) {
        guard let urlString = url else {return}
        guard let targetUrl = URL(string: urlString) else {return}
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = true
        let safariVC = SFSafariViewController(url: targetUrl, configuration: configuration)
        homeVC.present(safariVC, animated: true, completion: nil)
    }
}
