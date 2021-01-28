//
//  FirebaseAuthVC.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 24.01.21.
//

import UIKit

class signUpViewController: UIViewController {
    
    // Dependecies
    private let userValidator = Dependencies.container.resolve(UserFieldsValidator.self)!
    private let userdataSaver = Dependencies.container.resolve(UserdataSaver.self)!
    
    //Outlets
    @IBOutlet private weak var firstNameField: UITextField!
    @IBOutlet private weak var lastNameField: UITextField!
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var errorMessage: UILabel!{
        didSet{
            errorMessage.alpha = 0
        }
    }
    @IBOutlet private weak var signUp: RoundedButton!{
        didSet{
            signUp.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    @IBOutlet private weak var backButton: RoundedButton!{
        didSet{
            backButton.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButtonSwitcher ()
        // Do any additional setup after loading the view.
    }

    @IBAction func backPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func signUpPressed(_ sender: UIButton) {
        self.indicatorState(true)
        
        //Validate fields
        let error = validateFields()
        if error != nil {
            self.indicatorState(false)
            showError(error!)
            return
        }
        //Create user
        if let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let firstName = firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let lastName = lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            var newUserData = Userdata()
            newUserData.firstName = firstName
            newUserData.lastName = lastName
            newUserData.username = email
            newUserData.password = password
            userdataSaver.createUser(newUser: newUserData) { requestResult in
                if requestResult != nil {
                    self.indicatorState(false)
                    self.showError(requestResult!)
                } else {
                    self.indicatorState(false)
                    userdata.firstName = firstName
                    userdata.lastName = lastName
                    userdata.username = email
                    userdata.lastLoginDate = Date()
                    let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabVC")
                    self.navigationController?.pushViewController(tabVC, animated: true)
                }
            }
        }
    }
    
    @IBAction private func emailChanged(_ sender: UITextField) {
        signUpButtonSwitcher ()
    }
    @IBAction private func passwordChanged(_ sender: UITextField) {
        signUpButtonSwitcher ()
    }
    
    private func validateFields() -> String? {
        if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            {
            return "Please fill all fields"
        }
        return nil
    }
    
    private func showError(_ message: String) {
        errorMessage.text = message
        errorMessage.alpha = 1
    }
    
    private func indicatorState (_ state: Bool) {
        if state {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }
    
    private func signUpButtonSwitcher () {
        if userValidator.loginFieldsCheck(emailField.text ?? "", passwordField.text ?? "") {
            signUp.isEnabled = true
            signUp.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            signUp.isEnabled = false
            signUp.layer.borderColor = UIColor.systemGray.cgColor
        }
    }
}
