//
//  ProfileViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit
import Swinject
import Firebase

class ProfileViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var lastLoginLb: UILabel!
    @IBOutlet weak var logoutBtn: RoundedButton! {
        didSet {
            logoutBtn.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    @IBOutlet weak var LogoutbottomNSC: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        LogoutbottomNSC.constant -= view.bounds.height/5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        LogoutbottomNSC.constant += view.bounds.height/5
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: { [weak self] in self?.view.layoutIfNeeded()}, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        usernameLabel.text = userdata.username
        nameLabel.text = userdata.firstName
        lastNameLabel.text = userdata.lastName
        lastLoginLb.text = "\(userdata.lastLoginDate)"

    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        Dependencies.container.resolve(EventManager.self)?.notify()
        
        let firebase = Auth.auth()
        do {
            try firebase.signOut()
        } catch let signOutErr as NSError {
            print(signOutErr.localizedDescription)
            return
        }
    }
}
