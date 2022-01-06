//
//  UserViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/5/22.
//

import UIKit
import FirebaseAuth

class UserViewController: UIViewController {


    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    
    var IsAutoLogin = false
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.setButtonStyle(logoutButton)
        Utilities.setButtonStyle(changePasswordButton)
        
        if UserDefaults.IsExisit(forKey: "IsAutoLogin"){
            IsAutoLogin = userDefaults.bool(forKey: "IsAutoLogin")
        } else {
            userDefaults.setValue(IsAutoLogin, forKey: "IsAutoLogin")
        }
        autoLoginSwitch.setOn(IsAutoLogin, animated: false)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggleAutoLoginSwitch(_ sender: Any) {
        IsAutoLogin = autoLoginSwitch.isOn
        userDefaults.setValue(IsAutoLogin, forKey: "IsAutoLogin")
    }
    
    @IBAction func tapLogoutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }
        catch let error as NSError{
            let alert = UIAlertController(title: "Error occurred", message: error.localizedDescription, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
       
        let LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController
        self.view.window?.rootViewController = LoginViewController
        self.view.window?.makeKeyAndVisible()
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
