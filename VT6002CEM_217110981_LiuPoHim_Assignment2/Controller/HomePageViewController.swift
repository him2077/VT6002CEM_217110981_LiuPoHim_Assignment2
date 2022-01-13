//
//  HomePageViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/4/22.
//

import UIKit
import Firebase
import FirebaseAuth

class HomePageViewController: UIViewController {

    @IBOutlet weak var activitiesButton: UIButton!
    @IBOutlet weak var craftsmanshipsButton: UIButton!
    
    @IBOutlet weak var favouritesButton: UIButton!
    @IBOutlet weak var IconButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeAlert()
    }
    
    func welcomeAlert(){
        let db = Firestore.firestore()
        let userRef = db.collection("user").document(Auth.auth().currentUser!.uid)
        var nickName : String?
        
        userRef.getDocument { document, error in
            if let document = document, document.exists{
                let docData = document.data()
                nickName = docData!["Nick Name"] as? String ?? ""
                let alert = UIAlertController(title: nil, message: "Welcome \(nickName!)!", preferredStyle: .alert)
                let start = UIAlertAction(title: "Start", style: .default)
                alert.addAction(start)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    @IBAction func tapActivitiesButton(_ sender: Any) {
        let TabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        TabBarController.selectedViewController = TabBarController.viewControllers?[1]
        present(TabBarController, animated: true, completion: nil)
    }
    
    @IBAction func tapFavouritesButton(_ sender: Any) {
        let TabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        TabBarController.selectedViewController = TabBarController.viewControllers?[0]
        present(TabBarController, animated: true, completion: nil)
    }
    
    @IBAction func tapCraftsmanshipButton(_ sender: Any) {
        let TabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        TabBarController.selectedViewController = TabBarController.viewControllers?[2]
        present(TabBarController, animated: true, completion: nil)
    }
    
    @IBAction func tapIconButton(_ sender: Any) {
        let TabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        TabBarController.selectedViewController = TabBarController.viewControllers?[3]
        present(TabBarController, animated: true, completion: nil)
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
