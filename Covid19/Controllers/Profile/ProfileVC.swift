//
//  ProfileViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit
import Swinject

class ProfileVC: UIViewController {

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
        //lastLoginLb.text = "\(String(userdata.lastLogin).dropLast(14))"


    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {

        //navigationController?.tabBarController?.navigationController?.popToRootViewController(animated: true)
        navigationController?.popToRootViewController(animated: true)
        Dependencies.container.resolve(EventManager.self)?.notify()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
