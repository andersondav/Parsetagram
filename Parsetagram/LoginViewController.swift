//
//  LoginViewController.swift
//  
//
//  Created by Anderson David on 2/11/19.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                // Do stuff after successful login.
                self.errorLabel.isHidden = true
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                // The login failed. Check error to see why.
                print("error: \(error?.localizedDescription)")
                self.errorLabel.text = "Username or Password is incorrect."
                self.errorLabel.isHidden = false
            }
        }
    
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.errorLabel.isHidden = true
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("error: \(error?.localizedDescription)")
                if ((error?.localizedDescription.contains("already"))!) {
                    self.errorLabel.text = "Account already exists for this username."
                    self.errorLabel.isHidden = false
                } else {
                    self.errorLabel.text = "There was an error. Please retry"
                    self.errorLabel.isHidden = false
                }
                
            }
        }
        
    }
    
    @IBAction func exitKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}
