//
//  AuthViewController.swift
//  Photog
//
//  Created by Jordan Hudgens on 10/13/14.
//  Copyright (c) 2014 Jordan Hudgens. All rights reserved.
//

import UIKit

enum AuthMode
{
    case SignIn
    case SignUp
}

class AuthViewController: UIViewController, UITextFieldDelegate {

    var authMode : AuthMode = AuthMode.SignIn
    @IBOutlet var emailTextField : UITextField?
    @IBOutlet var passwordTextField : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = UIRectEdge.None
        
        var emailImageView = UIImageView(frame: CGRectMake(0, 0, 50, self.emailTextField!.frame.size.height))
        emailImageView.image = UIImage(named: "EmailIcon")
        emailImageView.contentMode = .Center
        
        self.emailTextField!.leftView = emailImageView
        self.emailTextField!.leftViewMode = .Always
        
        var passwordImageView = UIImageView(frame: CGRectMake(0, 0, 50, self.passwordTextField!.frame.size.height))
        passwordImageView.image = UIImage(named: "PasswordIcon")
        passwordImageView.contentMode = .Center
        
        self.passwordTextField!.leftView = passwordImageView
        self.passwordTextField!.leftViewMode = .Always
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.emailTextField?.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == self.emailTextField) {
            self.emailTextField?.resignFirstResponder()
            self.passwordTextField?.becomeFirstResponder()
        } else if (textField == self.passwordTextField) {
            self.passwordTextField?.resignFirstResponder()
            self.authenticate()
        }
        
        return true
    }
    
    func authenticate() {
        var email = self.emailTextField?.text
        var password = self.passwordTextField?.text
        
        var myAlert = UIAlertController()
        
        if (email?.isEmpty == true || password?.isEmpty == true || email?.isEmailAddress() == false)
        {
            // alert the user
            println("empty string")
            
            
            let alertController = UIAlertController(title: "Validation error", message: "Sorry, you need to enter the appropriate values.", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // ...
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                // ...
            }
            
            return
        }
        
        if authMode == .SignIn {
            self.signIn(email!, password: password!)
        } else {
            self.signUp(email!, password: password!)
        }
        
        // otherwise, authenticate
        println("full string")
    }
    
    func signIn(email: String, password: String)
    {
        println("sign in")
    }
    
    func signUp(email: String, password: String)
    {
        println("sign up")
    }

}
