//
//  ViewController.swift
//  SleepAP
//
//  Created by Wu, Tianyuan on 10/16/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Parse

class loginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.text = ""
        passwordTextField.text = ""
        
        cardView.layer.cornerRadius = 10;
        cardView.layer.masksToBounds = true;
    }
    override func viewDidAppear(_ animated: Bool){
        let currentUser = PFUser.current()
        if currentUser != nil {
            //@TODO
            loadHomeScreen()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // After login, show the main board
    func loadHomeScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
        present(vc, animated: false, completion: nil)
    }

    
    @IBAction func login(_ sender: Any) {
//        if (usernameTextField.text != nil) && (passwordTextField.text != nil) {
//            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) {
//                (user, error) -> Void in
//                if let loggeduser = user {
//                    //@TODO
//                    self.loadHomeScreen()
//                } else {
//                    // The login failed. Check error to see why.
//                    // TODO: tell the user about the failure
//                }
//            }
//        }
        if let signUpView = self.view.viewWithTag(100) {
            signUpView.removeFromSuperview()
            signUpView.isHidden = true
        }
        cardView.addSubview(loginView)
    }


    @IBAction func signUp(_ sender: UIButton) {
        
    }
}

