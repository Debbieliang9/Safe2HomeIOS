//
//  LogInViewController.swift
//  SnapchatProject
//
//  Created by Daniel Phiri on 10/13/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import UIKit

import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userEmail = ""
    var userPassword = ""
    
    @IBAction func logInPressed(_ sender: UIButton) {
        // TODO:
        // Replace the following line with the code in the README and complete the
        // code as required.

        
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        
        if emailText == "" || passwordText == "" {
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields
            let alertController = UIAlertController(title: "Log In Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
            
                if error == nil {
                
                    self.performSegue(withIdentifier: segueLogInToMainPage, sender: self)
            }

                    if (error != nil){
                        let alertController = UIAlertController(title: "Log In Error", message:
                            error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    
                    }
                }
            
            }
            
        }
    
            
            

    
    @IBAction func signUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier:segueLogInToSignUp, sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    //TO DO:
    // Authenticate users automatically if they already signed in earlier.
    // Hint: Just check if the current user is nil using firebase and if not, perform a segue. You're welcome :)
    override func viewDidAppear(_ animated: Bool) {
        //YOUR CODE HERE
        if Auth.auth().currentUser != nil {
            //performSegue(withIdentifier:segueLogInToSignUp, sender: self)
            self.performSegue(withIdentifier: segueLogInToMainPage, sender: self)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            if textField.text != nil {
                self.userEmail = textField.text!
            }
        } else {
            if textField.text != nil {
                self.userPassword = textField.text!
            }
        }
    }
}
