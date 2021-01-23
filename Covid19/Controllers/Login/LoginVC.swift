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
    
    // Dependecies
    private let userValidator = Dependencies.container.resolve(UserFieldsValidator.self)!
    private let styleProvider = Dependencies.container.resolve(UIstyle.self)!
    
    //Outlets
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    
    @objc private func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: kbFrameSize.height, bottom: 0, right: 0)
    }
    
    @objc private func kbDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
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
        self.view.backgroundColor = styleProvider.getBgColor()
        self.usernameInputField.textColor = styleProvider.getTextColor()
        self.passwordInputField.textColor = styleProvider.getTextColor()
    }
    
}


