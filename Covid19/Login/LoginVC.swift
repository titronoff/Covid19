//
//  ViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 10/30/20.
//

import UIKit

class Downloader {
    
    class func downloadImageWithURL(url:String) -> UIImage! {
        
        if let data = NSData(contentsOf: NSURL(string: url)! as URL) {
            return UIImage(data: data as Data)
        } else {
            return UIImage()
        }
    }
}

 var user = Userdata(username: "")
 var articles = [Article]()
 var cases = [Case]()
 var queue = OperationQueue()

class LoginVC: UIViewController {

    @IBOutlet weak var c2: NSLayoutConstraint!
    

    @IBOutlet weak var usernameInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    //@IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        c2.constant += view.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadIndicator.isHidden = true
        getLoginData()
        loginCheck()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        c2.constant -= view.bounds.height
        UIView.animate(withDuration: 1, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        saveLoginData()
        let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabVC")
        self.navigationController?.pushViewController(tabVC, animated: true)
    }

    @IBAction func usernameChanged(_ sender: UITextField) {
        loginCheck()
    }

    @IBAction func pswdChanged(_ sender: UITextField) {
        loginCheck()
    }
}


