//
//  ViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 10/30/20.
//

import UIKit

 var user = Userdata(username: "")




class LoginViewController: UIViewController {

    @IBOutlet weak var c2: NSLayoutConstraint!
    

    @IBOutlet weak var usernameInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    
    override func viewWillAppear(_ animated: Bool) {
        c2.constant += view.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //last login
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
    }

    @IBAction func usernameChanged(_ sender: UITextField) {
        loginCheck()
    }

    @IBAction func pswdChanged(_ sender: UITextField) {
        loginCheck()
    }
}


