//
//  ViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 10/30/20.
//

import UIKit
import SafariServices
import Swinject
import GoogleSignIn
import PKHUD

var userdata = Userdata()

class LoginViewController: UIViewController {
    
    // Dependecies
    private let userValidator = Dependencies.container.resolve(UserFieldsValidator.self)!
    private let styleProvider = Dependencies.container.resolve(UIstyle.self)!
    private let userdataValidator = Dependencies.container.resolve(UserdataValidator.self)!
    private let keychainUserdata = KeychainUserdataService()
    
    //Outlets
    @IBOutlet weak var leadingSpace: NSLayoutConstraint!
    @IBOutlet  weak var usernameInputField: UITextField!
    @IBOutlet  weak var passwordInputField: UITextField!
    @IBOutlet private weak var loginButton: RoundedButton!
    @IBOutlet weak var SignInButton: RoundedButton!{
        didSet{
            SignInButton.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
// MARK: Animation
    override func viewWillAppear(_ animated: Bool) {
        leadingSpace.constant += view.bounds.width
    }
    override func viewDidAppear(_ animated: Bool) {
        leadingSpace.constant -= view.bounds.width
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }
// set up and evaluate
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        usernameInputField.text = keychainUserdata.getLoginData()
        loginButtonSwitcher ()
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
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
    
    @IBAction private func signUpPressed(_ sender: RoundedButton) {
        let signUpVC = UIStoryboard(name: "Signup", bundle: nil).instantiateViewController(withIdentifier: "signUpVC") as! signUpViewController
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction private func loginPressed(_ sender: UIButton) {
        indicatorState(true)
        let login = usernameInputField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pswd = passwordInputField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        userdataValidator.userLogIn(email: login, password: pswd) {requestResult in
            if requestResult != nil {
                self.indicatorState(false, true)
                self.showError(requestResult!)
            } else {
                self.indicatorState(false)
                HUD.flash(.success, delay: 1.0)
                self.keychainUserdata.saveLoginData(username: login)
                let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabVC")
                self.navigationController?.pushViewController(tabVC, animated: true)
            }
        }
    }

    @IBAction func googleAuthorizationPressed(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
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
    private func showError(_ message: String) {
        HUD.flash(.label(message), delay: 2)
    }
    private func indicatorState (_ state: Bool, _ error: Bool = false) {
        if state {
            HUD.show(.progress)
        } else {
            if error {
                HUD.flash(.success, delay: 1.0)
            } else {
                HUD.flash(.success, delay: 0)
            }
        }
    }
}
