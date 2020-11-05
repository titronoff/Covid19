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
        let lastSuccesLoginData = UserDefaults.standard.data(forKey: "key1")
        if let lastSuccesLoginData = lastSuccesLoginData {
            let decoder = PropertyListDecoder()
            let restoredUser = try? decoder.decode(Userdata.self, from: lastSuccesLoginData)
            print("Restore last session - Username: \(restoredUser?.username ?? "")")
        }
        
        loginCheck()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        c2.constant -= view.bounds.height
        UIView.animate(withDuration: 1, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func passwordInputChanged(_ sender: UITextField) {
        loginCheck()
    }
    
    @IBAction func usernameInputChanged(_ sender: UITextField) {
        loginCheck()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        user.username = usernameInputField.text ?? ""
        if user.username != "" {
            let encoder = PropertyListEncoder()
            let data = try? encoder.encode(user)
            UserDefaults.standard.setValue(data, forKey: "key1")
        }
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


