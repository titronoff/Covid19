//
//  ViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 10/30/20.
//

import UIKit

 var username = ""




class LoginViewController: UIViewController {

    @IBOutlet weak var usernameInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginCheck()
    }
    
    @IBAction func passwordInputChanged(_ sender: UITextField) {
        loginCheck()
    }
    
    @IBAction func usernameInputChanged(_ sender: UITextField) {
        loginCheck()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        username = usernameInputField.text ?? ""
    }
    
    func loginCheck() {
        if usernameInputField.text! != "" && passwordInputField.text != "" {
        loginButton.isEnabled = true
        loginButton.backgroundColor = .systemGreen
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .lightGray
        }
    }
    
}


