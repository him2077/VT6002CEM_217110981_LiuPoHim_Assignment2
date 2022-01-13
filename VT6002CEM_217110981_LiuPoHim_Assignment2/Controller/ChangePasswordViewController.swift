//
//  ChangePasswordViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/6/22.
//

import UIKit
import FirebaseAuth

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        setStyle()
    }
    
    func setStyle(){
        let newColor = UIColor.init(_colorLiteralRed: 52/255, green: 119/255, blue: 1, alpha: 1)
        Utilities.setTextFieldStyle(oldPasswordTextField, color: newColor)
        Utilities.setTextFieldStyle(newPasswordTextField, color: newColor)
        Utilities.setTextFieldStyle(confirmPasswordTextField, color: newColor)
        Utilities.setButtonStyle(changePasswordButton)
        Utilities.setButtonStyle(cancelButton, cornerRadius: 15)
    }
    
    @IBAction func tapCancelButton(_ sender: Any) {
        goBack()
    }
    
    func goBack(){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tapChangePasswordButton(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil{
            showErrorMessage(message: error!)
        }
        else{
            let email = Auth.auth().currentUser?.email
            let oldPassword = oldPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let newPassword = newPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let credential = EmailAuthProvider.credential(withEmail: email!, password: oldPassword)
                        
            Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (result, error) in
                if error != nil{
                    self.showErrorMessage(message: error!.localizedDescription)
                }
                else {
                    Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { error in
                        if error != nil{
                            self.showErrorMessage(message: error!.localizedDescription)
                        }
                        else{
                            let alert = UIAlertController(title: nil, message: "Password changed successfully", preferredStyle: .alert)
                            self.present(alert, animated: true, completion: nil)
                            self.goBack()
                        }
                    })
                }
            })
            
            
        }
    }
    
    
    func validateFields() -> String?{
        if oldPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.setTextFieldStyle(oldPasswordTextField, color: UIColor.red)
            return "Please fill in all fields"
        }
        if newPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.setTextFieldStyle(newPasswordTextField, color: UIColor.red)
            return "Please fill in all fields"
        }
        if confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.setTextFieldStyle(confirmPasswordTextField, color: UIColor.red)
            return "Please fill in all fields"
        }
        
        let newPassword = newPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPassword = confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.CheckInputValid(newPassword) == false {
            Utilities.setTextFieldStyle(newPasswordTextField, color: UIColor.red)
            return "Please make sure your password at least 8 characters, contain a UPPERCASE letter and a lowercase letter"
        }
        else{
            Utilities.setTextFieldStyle(newPasswordTextField, color: UIColor.green)
        }
        
        if newPassword != confirmPassword{
            Utilities.setTextFieldStyle(confirmPasswordTextField, color: UIColor.red)
            return "Please make sure your password is the same as you input last time"
        }
        else{
            Utilities.setTextFieldStyle(confirmPasswordTextField, color: UIColor.green)
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
