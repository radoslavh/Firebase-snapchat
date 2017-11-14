//
//  ViewController.swift
//  Firebase-snapchat
//
//  Created by Radoslav Hlinka on 14/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print ("attempt")
            if error != nil{
                print("Error: \(error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    if error  != nil {
                        print("creation error")
                    }else{
                        print("create user succesfully")
                    }
                })
            }else{
                print("Sign in")
            }
            
        }
        
    }
    
}

