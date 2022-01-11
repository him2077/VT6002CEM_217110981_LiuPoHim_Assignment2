//
//  ActivitiesDetailViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/11/22.
//

import UIKit
import Firebase
import FirebaseAuth

class ActivitiesDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    var titleContent: String = ""
    var introductionContent: String = ""
    var detailContent: String = ""
    var locationContent = ""
    var latitude : Double = 0
    var longitude : Double = 0
    var IsFavorite = false
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.setButtonStyle(locationButton)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = titleContent
        introductionLabel.text = introductionContent.replacingOccurrences(of: "\\n", with: "\n") + "\nVenue:\n" + locationContent.replacingOccurrences(of: "\\n", with: "\n")
        detailLabel.text = "Detail \n" + detailContent.replacingOccurrences(of: "\\n", with: "\n")
        checkIsFavorite()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LocationViewController {
            destination.location = LocationViewController.Location(title: locationContent, latitude: latitude, longitude: longitude)
            
        }
    }
    
    func checkIsFavorite(){
        let favouriteRef = db.collection("user").document(Auth.auth().currentUser!.uid).collection("Favorites").document(titleContent)
        favouriteRef.getDocument { snapshot, error in
            if snapshot!.exists{
                self.IsFavorite = true
                self.favouriteButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            }
            else{
                self.IsFavorite = false
                self.favouriteButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    
    @IBAction func toggleFavoriteButton(_ sender: Any) {
        if !IsFavorite{
            db.collection("user").document(Auth.auth().currentUser!.uid).collection("Favorites").document("\(titleContent)").setData([
                "Title" : titleContent,
                "Introduction" : introductionContent,
                "Detail" : detailContent,
                "Location" : locationContent,
                "Latitude" : latitude,
                "Longitude" : longitude
            ], completion: { (error) in
                    if error != nil{
                        print("User data storing fail: \(error!.localizedDescription)")
                    }
            })
            IsFavorite = true
            self.favouriteButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else{
            db.collection("user").document(Auth.auth().currentUser!.uid).collection("Favorites").document("\(titleContent)").delete()
            IsFavorite = false
            self.favouriteButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        }
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
