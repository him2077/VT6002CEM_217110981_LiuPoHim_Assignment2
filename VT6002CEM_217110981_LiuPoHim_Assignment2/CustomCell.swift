//
//  CustomCell.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/9/22.
//

import UIKit
import Firebase
import FirebaseAuth

class CustomCell: UITableViewCell {
    let db = Firestore.firestore()
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var introduction: UILabel!
    var detailContent : String = ""
    var introductionContent: String = ""
    var locationContent = ""
    var latitude : Double = 0
    var longitude : Double = 0
    @IBOutlet weak var favoriteButton: UIButton!
    
    var IsFavorite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    func checkIsFavorite(){
        let favouriteRef = db.collection("user").document(Auth.auth().currentUser!.uid).collection("Favorites").document(title.text ?? "")
        favouriteRef.getDocument { snapshot, error in
            if snapshot!.exists{
                self.IsFavorite = true
                self.favoriteButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            }
            else{
                self.IsFavorite = false
                self.favoriteButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
            }
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func toggleFavorite(_ sender: Any) {
        if !IsFavorite{
            if(locationContent == ""){
                db.collection("user").document(Auth.auth().currentUser!.uid).collection("Favorites").document("\(title.text ?? "")").setData([
                    "Title" : title.text ?? "",
                    "Introduction" : introductionContent,
                    "Detail" : detailContent
                ], completion: { (error) in
                        if error != nil{
                            print("User data storing fail: \(error!.localizedDescription)")
                        }
                })
            }
            else{
                db.collection("user").document(Auth.auth().currentUser!.uid).collection("Favorites").document("\(title.text ?? "")").setData([
                    "Title" : title.text ?? "",
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
            }
            IsFavorite = true
            self.favoriteButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else{
            db.collection("user").document(Auth.auth().currentUser!.uid).collection("Favorites").document("\(title.text ?? "DF1")").delete()
            IsFavorite = false
            self.favoriteButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        }
    }
        
        
}
    

