//
//  FavoritesViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/11/22.
//

import UIKit
import Firebase
import FirebaseAuth

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var favoritesList = [dataStructure]()
    var cellSpacing : CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200;
        tableView.rowHeight = UITableView.automaticDimension
        getData{ () -> () in
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ActivitiesDetailViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let section = indexPath.section
                destination.titleContent = self.favoritesList[section].title
                destination.introductionContent = self.favoritesList[section].introduction
                destination.detailContent = self.favoritesList[section].detail
                destination.locationContent = self.favoritesList[section].location
                destination.latitude = self.favoritesList[section].latitude
                destination.longitude = self.favoritesList[section].longitude
                
            }
        }
        if let destination = segue.destination as? DetailViewController{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let section = indexPath.section
                destination.titleContent = self.favoritesList[section].title
                destination.introductionContent = self.favoritesList[section].introduction
                destination.detailContent = self.favoritesList[section].detail
            }
        }
    }
    
    // MARK: - get data from firestore
    func getData(completed: @escaping () -> Void){
        
        let db = Firestore.firestore()
        let FavoritesRef = db.collection("user").document(Auth.auth().currentUser!.uid).collection("Favorites")
        
        FavoritesRef.getDocuments { snapshot, error in
            if error != nil {
                print("\(error!.localizedDescription)")
            }
            else {
                if let snapshot = snapshot{
                    self.favoritesList = snapshot.documents.map({ doc in
                        return dataStructure(title: doc["Title"] as? String ?? "",
                                             introduction: doc["Introduction"] as? String ?? "",
                                             detail: doc["Detail"] as? String ?? "",
                                             location: doc["Location"] as? String ?? "",
                                             latitude: doc["Latitude"] as? Double ?? 0,
                                             longitude: doc["Longitude"] as? Double ?? 0)
                    })
                }
                completed()
            }
        }

    }
    
    // MARK: - table view setting
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return favoritesList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "activitiesCell") as! CustomCell
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true

        cell.title?.text = self.favoritesList[indexPath.section].title
        cell.introduction?.text = "Introduction: \n" + self.favoritesList[indexPath.section].introduction.replacingOccurrences(of: "\\n", with: "\n") + "\nVenue:\n" + self.favoritesList[indexPath.section].location.replacingOccurrences(of: "\\n", with: "\n")
        cell.introductionContent = self.favoritesList[indexPath.section].introduction
        cell.detailContent = self.favoritesList[indexPath.section].detail
        cell.locationContent = self.favoritesList[indexPath.section].location
        cell.latitude = self.favoritesList[indexPath.section].latitude
        cell.longitude = self.favoritesList[indexPath.section].longitude
        cell.checkIsFavorite()
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if favoritesList[indexPath.section].location == ""{
            self.performSegue(withIdentifier: "showDetail", sender: nil)
        }
        else{
            self.performSegue(withIdentifier: "showActivitiesDetail", sender: nil)
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
