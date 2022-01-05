//
//  HomePageViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/4/22.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var activitiesButton: UIButton!
    @IBOutlet weak var locationsButton: UIButton!
    
    @IBOutlet weak var favouritesButton: UIButton!
    @IBOutlet weak var IconButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func tapLocationsButton(_ sender: Any) {
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
