//
//  ProfileViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        usernameLabel.text = user.username
        

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {

        //navigationController?.tabBarController?.navigationController?.popToRootViewController(animated: true)
        navigationController?.popToRootViewController(animated: true)
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