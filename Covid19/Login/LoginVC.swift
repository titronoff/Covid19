//
//  ViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 10/30/20.
//

import UIKit

class Downloader {
    
    class func downloadImageWithURL(url:String) -> UIImage! {
        
        if let data = NSData(contentsOf: NSURL(string: url)! as URL) {
            return UIImage(data: data as Data)
        } else {
            return UIImage()
        }
    }
}

 var user = Userdata(username: "")
 var articles = [Article]()
 var cases = [Case]()
 var queue = OperationQueue()

class LoginVC: UIViewController {

    @IBOutlet weak var c2: NSLayoutConstraint!
    

    @IBOutlet weak var usernameInputField: UITextField!
    @IBOutlet weak var passwordInputField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        c2.constant += view.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadIndicator.isHidden = true
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
        loadIndicator.isHidden = false
        loadIndicator.hidesWhenStopped = true
        loadIndicator.startAnimating()
        CasesTVC.getCases()
        getNewsFeedData()
    }

    @IBAction func usernameChanged(_ sender: UITextField) {
        loginCheck()
    }

    @IBAction func pswdChanged(_ sender: UITextField) {
        loginCheck()
    }
    
    
    
    func getNewsFeedData() {
        let urlString = "https://newsapi.org/v2/top-headlines?q=covid&apiKey=084c67c2b33148828b786875cbed3fc2"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                //handle error
                print(error)
            }
            guard let data = data else {return}
            do {
                let newsFeed = try JSONDecoder().decode(NewsFeed.self, from: data)
                guard let newArticles = newsFeed.articles else {return}
                DispatchQueue.main.async {
                    articles = newArticles
                    print("afetr parsing counting: ", articles.count ?? "nil")
                    print("load news view ->")
                    self.loadIndicator.stopAnimating()
                    let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabVC")
                    self.navigationController?.pushViewController(tabVC, animated: true)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
}


