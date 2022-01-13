//
//  LoginViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/4/22.
//

import UIKit
import FirebaseAuth
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var biometricAuthButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var rememberSwitch: UISwitch!
    
    
    private var IsRememberMe = false
    let userDefaults = UserDefaults.standard
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        setStyle()
        
        if UserDefaults.IsExisit(forKey: "IsRememberMe"){
            IsRememberMe = userDefaults.bool(forKey: "IsRememberMe")
        } else {
            userDefaults.setValue(IsRememberMe, forKey: "IsRememberMe")
        }
        rememberSwitch.setOn(IsRememberMe, animated: false)
        
        if IsRememberMe{
            emailTextField.text = userDefaults.string(forKey: "UserEmail")
        }
        
        if user == nil{
            biometricAuthButton.isEnabled = false
            biometricAuthButton.alpha = 0.1
        }
        
        if UserDefaults.IsExisit(forKey: "IsAutoLogin"){
            let IsAutoLogin = userDefaults.bool(forKey: "IsAutoLogin")
            if IsAutoLogin && user != nil {
                transferToHomePage()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func setStyle(){
        let newColor = UIColor.init(_colorLiteralRed: 52/255, green: 119/255, blue: 1, alpha: 1)
        Utilities.setTextFieldStyle(emailTextField, color: newColor)
        Utilities.setTextFieldStyle(passwordTextField, color: newColor)
        Utilities.setButtonStyle(loginButton)
    }
    
    @IBAction func toggleRemeberMe(_ sender: Any) {
        IsRememberMe = rememberSwitch.isOn
        userDefaults.setValue(IsRememberMe, forKey: "IsRememberMe")
    }
    
    @IBAction func tapLoginButton(_ sender: Any) {
        
        let error = validateFields()
        if error != nil{
            showErrorMessage(message: error!)
        }
        else{
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            login(email: email, password: password){ (result,error) in
                if error != nil{
                    self.showErrorMessage(message: error!.localizedDescription)
                }
                else{
                    if result {
                        if(self.IsRememberMe){
                            self.userDefaults.setValue(email, forKey: "UserEmail")
                        }
                        self.transferToHomePage()
                    }
                }
            }
        }
    }
    
    func login(email: String, password: String, completed: @escaping (_ Result:Bool, _ Error:NSError?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                completed(false, error! as NSError)
            }
            else{
                completed(true, nil)
            }
        }
    }
    
    private func transferToHomePage(){
        let HomePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVC") as? HomePageViewController
        self.view.window?.rootViewController = HomePageViewController
        self.view.window?.makeKeyAndVisible()
        present(HomePageViewController!, animated: true, completion: nil)
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
    
    // MARK: - Biometric Authentication (from Biometric lab)
    @IBAction func BiometricAuthentication(_ sender: Any) {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Access requires authentication",
                                   reply: {(success, error) in
                                    DispatchQueue.main.async {
                                        if let error = error {
                                            switch error._code {
                                            case LAError.Code.systemCancel.rawValue:
                                                self.showNotifyMessage("Session cancelled",
                                                           err: error.localizedDescription)
                                            case LAError.Code.userCancel.rawValue:
                                                self.showNotifyMessage("Please try again",
                                                           err: error.localizedDescription)
                                            case LAError.Code.userFallback.rawValue:
                                                self.showNotifyMessage("Authentication",
                                                           err: "Password option selected")
                                            default:
                                                self.showNotifyMessage("Authentication failed",
                                                           err: error.localizedDescription)
                                            }
                                        } else{
                                            self.transferToHomePage()
                                        }
                                    }
                                   })
            
        } else{
            if let error = error{
                switch error.code {
                case LAError.Code.biometryNotEnrolled.rawValue:
                    showNotifyMessage("User is enrolled",
                               err: error.localizedDescription)
                case LAError.Code.passcodeNotSet.rawValue:
                    showNotifyMessage("A passcode has not been set",
                               err: error.localizedDescription)
                case LAError.Code.biometryNotAvailable.rawValue:
                    showNotifyMessage("Biometric authentication not available",
                               err: error.localizedDescription)
                default:
                    showNotifyMessage("Unknown error",
                               err: error.localizedDescription)
                }
            }
        }
    }
    
    func showNotifyMessage(_ msg: String, err: String?){
        let alert = UIAlertController(title: msg, message: err, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
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
