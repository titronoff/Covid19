//
//  ViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 10/30/20.
//

import UIKit
import SafariServices

 var userdata = Userdata()

class LoginVC: UIViewController {

    @IBOutlet weak var c2: NSLayoutConstraint!
    

    @IBOutlet weak var usernameInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var loginButton: RoundedButton! 
    //@IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
// MARK: Animation
    override func viewWillAppear(_ animated: Bool) {
        c2.constant += view.bounds.height
    }
    override func viewDidAppear(_ animated: Bool) {
        c2.constant -= view.bounds.height
        UIView.animate(withDuration: 1, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }
// set up and evaluate
    override func viewDidLoad() {
        super.viewDidLoad()
        getLoginData()
        loginCheck()
        
        print(Date())
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


