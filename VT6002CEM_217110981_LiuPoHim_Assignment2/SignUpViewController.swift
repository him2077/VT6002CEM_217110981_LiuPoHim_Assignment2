//
//  SignUpViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/4/22.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        setStyle()
        // Do any additional setup after loading the view.
    }
    
    func setStyle(){
        let newColor = UIColor.init(_colorLiteralRed: 52/255, green: 119/255, blue: 1, alpha: 1)
        Utilities.setTextFieldStyle(nickNameTextField, color: newColor)
        Utilities.setTextFieldStyle(emailTextField, color: newColor)
        Utilities.setTextFieldStyle(passwordTextField, color: newColor)
        Utilities.setButtonStyle(signUpButton)
    }

    @IBAction func tapSignUpButton(_ sender: Any) {
        let error = validateFields()
        if error != nil{
            showErrorMessage(message: error!)
        }
        else{
            let nickName = nickNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error{
                    
                    self.showErrorMessage(message: "Error creating account")
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("user").addDocument(data: [
                        "Nick Name": nickName,
                        "Building": true,
                        "Crafts": true,
                        "Food": true,
                        "Music": true,
                        "UID": result!.user.uid
                    ]) { (error) in
                        if error != nil{
                            self.showErrorMessage(message: "User data storing fail")
                        }
                    }
                    self.login();
                    
                }
            }
        }
        
    }
    
    
    func validateFields() -> String?{
        if nickNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.setTextFieldStyle(passwordTextField, color: UIColor.red)
            return "Please fill in all fields"
        }
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.setTextFieldStyle(emailTextField, color: UIColor.red)
            return "Please fill in all fields"
        }
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.setTextFieldStyle(passwordTextField, color: UIColor.red)
            return "Please fill in all fields"
        }
        
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.CheckInputValid(password) == false {
            Utilities.setTextFieldStyle(passwordTextField, color: UIColor.red)
            return "Please make sure your password at least 8 characters, contain a UPPERCASE letter and a lowercase letter"
        }
        
        return nil
    }
    
    func showErrorMessage(message:String){
        
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    
    func login(){
        
        let HomePageViewController = storyboard?.instantiateViewController(withIdentifier: "HomePageCV") as? HomePageViewController
        view.window?.rootViewController = HomePageViewController
        view.window?.makeKeyAndVisible()
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
