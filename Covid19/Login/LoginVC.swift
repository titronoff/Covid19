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
        loginButtonSwitcher ()
        print(Date())
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        saveLoginData()
        let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabVC")
        self.navigationController?.pushViewController(tabVC, animated: true)
    }

    @IBAction func usernameChanged(_ sender: UITextField) {
        loginButtonSwitcher()
    }

    @IBAction func pswdChanged(_ sender: UITextField) {
        loginButtonSwitcher()
    }
    
    func loginButtonSwitcher () {
        if LoginValidator.loginCheck(usernameInputField.text ?? "", passwordInputField.text ?? "") {
            loginButton.isEnabled = true
            loginButton.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            loginButton.isEnabled = false
            loginButton.layer.borderColor = UIColor.systemGray.cgColor
        }
    }
}


