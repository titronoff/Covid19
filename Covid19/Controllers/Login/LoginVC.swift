//
//  ViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 10/30/20.
//

import UIKit
import SafariServices
import Swinject

var userdata = Userdata()

class LoginVC: UIViewController {
    
    private var userValidator = Dependencies.container.resolve(UserFieldsValidator.self)!
    private var network = NetworkService()
    
    @IBOutlet  weak var usernameInputField: UITextField!
    @IBOutlet  weak var passwordInputField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var c2: NSLayoutConstraint!
    
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
        setStyle()
        getLoginData()
        loginButtonSwitcher ()
        
        
        network.videosFetcher(urlString: Videogroups().groups[0].url)
        network.newsFetcher(urlString: News().items[0].url)
        network.casesFetcher(urlString: casesSourceUrl)
        
        
    }
    
    
    @IBAction private func loginPressed(_ sender: UIButton) {
        saveLoginData()
        let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabVC")
        self.navigationController?.pushViewController(tabVC, animated: true)
    }

    @IBAction private func usernameChanged(_ sender: UITextField) {
        loginButtonSwitcher()
    }

    @IBAction private func pswdChanged(_ sender: UITextField) {
        loginButtonSwitcher()
    }
    
    private func loginButtonSwitcher () {
        if userValidator.loginFieldsCheck(usernameInputField.text ?? "", passwordInputField.text ?? "") {
            loginButton.isEnabled = true
            loginButton.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            loginButton.isEnabled = false
            loginButton.layer.borderColor = UIColor.systemGray.cgColor
        }
    }
    
    private func setStyle() {
        let provider = StyleProvider()
        self.view.backgroundColor = provider.getBgColor()
        self.usernameInputField.textColor = provider.getTextColor()
        self.passwordInputField.textColor = provider.getTextColor()
    }
    
}


