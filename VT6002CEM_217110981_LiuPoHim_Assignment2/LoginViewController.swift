//
//  LoginViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/4/22.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var biometricAuthButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        setStyle()
        // Do any additional setup after loading the view.
    }
    
    func setStyle(){
        let newColor = UIColor.init(_colorLiteralRed: 52/255, green: 119/255, blue: 1, alpha: 1)
        Utilities.setTextFieldStyle(emailTextField, color: newColor)
        Utilities.setTextFieldStyle(passwordTextField, color: newColor)
        Utilities.setButtonStyle(loginButton)
    }
    
    @IBAction func tapLoginButton(_ sender: Any) {
        
        let error = validateFields()
        if error != nil{
            showErrorMessage(message: error!)
        }
        else{
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil{
                    self.showErrorMessage(message: error!.localizedDescription)
                }
                else{
                    let HomePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageCV") as? HomePageViewController
                    self.view.window?.rootViewController = HomePageViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
            
        }
    }
    
    @IBAction func tapBiometricButton(_ sender: Any) {
    }
    
    
    func validateFields() -> String?{
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.setTextFieldStyle(emailTextField, color: UIColor.red)
            return "Please fill in all fields"
        }
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.setTextFieldStyle(passwordTextField, color: UIColor.red)
            return "Please fill in all fields"
        }
                
        return nil
    }
    
    func showErrorMessage(message:String){
        
        errorLabel.text = message
        errorLabel.alpha = 1
        
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
