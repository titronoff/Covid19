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



//newsapi.org keys
var newsApiKey = ["084c67c2b33148828b786875cbed3fc2", //main
                  "836119757a1d4881ad4d1050682f658a", //1
                  "105f39ee084f4a7593a5df52902cba2e", //2
                  "9b23a0a02ce441419d1e10fa2376ab1c", //3
                  "0421233d9abb47b1a05338cf4e403508", //4
                  "fdbaf3a7e09b483daad5015193c88b68"] //5


//youtube keys
let ytAPIkey = ["AIzaSyCoCgCVy9txmg2ZrMgTV_S18O79-Tx8mtk",
                "AIzaSyAw00__z0F2SYuj_aXQ1-rHCMqBRfI9nP0",
                "AIzaSyAmj7frSfsjCq4NX0L5jM9whsqjale1xAw",
                "AIzaSyDE_4TyexEXr7dukhg0pRGyXyOG222wfGk",
                "AIzaSyBcvv6fcNbV03zhwfe3eVrGbiePisnJ3z0",
                "AIzaSyCznAzCpky2ugDBIyWHN_9ArrDB54pTSow"]
