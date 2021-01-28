//
//  LoginViewControllerMVVM.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 28.01.21.
//

import Foundation
import UIKit
import SafariServices
import Swinject
import PKHUD

class LoginViewControllerMVVM: UIViewController {
    
    private var viewModel = Dependencies.container.resolve(LoginViewModel.self)!
    
    @IBOutlet weak var loginButtonPressed: RoundedButton! {
        didSet{
            loginButtonPressed.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    @IBOutlet weak var loginInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var loginButton: RoundedButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginInputField.text = viewModel.keychainGetData()
        loginButtonSwitcher ()
    }
    
    @IBAction private func signUpPressed(_ sender: RoundedButton) {
        let signUpVC = UIStoryboard(name: "Signup", bundle: nil).instantiateViewController(withIdentifier: "signUpVC") as! signUpViewController
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction private func loginPressed(_ sender: UIButton) {
        indicatorState(true)
        self.viewModel.login {requestResult in
            if requestResult != nil {
                self.indicatorState(false, true)
                self.showError(requestResult!)
            } else {
                self.indicatorState(false)
                HUD.flash(.success, delay: 1.0)
                self.viewModel.keychainSaveData()
                let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabVC")
                self.navigationController?.pushViewController(tabVC, animated: true)
            }
        }
    }
    
    
    @IBAction func loginChanged(_ sender: UITextField) {
        self.viewModel.loginText = loginInputField.text ?? ""
        loginButtonSwitcher()
    }
    
    @IBAction func passwordChanged(_ sender: UITextField) {
        self.viewModel.passwordText = passwordInputField.text ?? ""
        loginButtonSwitcher()
    }
    


    
    private func loginButtonSwitcher () {
        if viewModel.buttonSwitcher() {
            loginButton.isEnabled = true
            loginButton.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            loginButton.isEnabled = false
            loginButton.layer.borderColor = UIColor.systemGray.cgColor
        }
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
