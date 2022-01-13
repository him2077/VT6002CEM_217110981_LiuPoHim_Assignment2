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
    
    let userDefaults = UserDefaults.standard
    var IsRememberMe : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        setStyle()
        
        IsRememberMe = userDefaults.bool(forKey: "IsRememberMe")
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
        let error = validateFields(nickName: nickNameTextField.text!, email: emailTextField.text!, password:  passwordTextField.text!)
        if error != nil{
            showErrorMessage(message: error!)
        }
        else{
            let nickName = nickNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            signUp(email: email, password: password, nickName: nickName, completed: { (result, error) in
                if let error = error{
                    
                    self.showErrorMessage(message: "\(error.localizedDescription)")
                }
                else{
                    if(self.IsRememberMe){
                        self.userDefaults.setValue(email, forKey: "UserEmail")
                    }
                    self.login();                    
                }
            })
        }
    }
    
    func signUp(email: String, password: String, nickName: String, completed: @escaping (_ Result:Bool, _ Error:NSError?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error{
                completed(false, error as NSError)
            }
            else{
                let db = Firestore.firestore()
                db.collection("user").document("\(result!.user.uid)").setData([
                    "Nick Name": nickName
                ]) { (error) in
                    if error != nil{
                        completed(true, error as NSError?)
                    }
                    completed(true, nil)
                }
            }
        }
    }
    
    func validateFields(nickName: String, email: String, password: String) -> String?{
        if nickName.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.setTextFieldStyle(passwordTextField, color: UIColor.red)
            return "Please fill in all fields"
        }
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.setTextFieldStyle(emailTextField, color: UIColor.red)
            return "Please fill in all fields"
        }
        if password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.setTextFieldStyle(passwordTextField, color: UIColor.red)
            return "Please fill in all fields"
        }
        
        let clearPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.CheckInputValid(clearPassword) == false {
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
        
        let HomePageViewController = storyboard?.instantiateViewController(withIdentifier: "HomePageVC") as? HomePageViewController
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
