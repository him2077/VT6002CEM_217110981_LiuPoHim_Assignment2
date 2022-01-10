//
//  ActivitiesViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/11/22.
//

import UIKit
import Firebase

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var activitiesList = [craftsmanship]()
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
        if let destination = segue.destination as? DetailViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let section = indexPath.section
                destination.titleContent = self.activitiesList[section].title
                destination.introductionContent = self.activitiesList[section].introduction
                destination.detailContent = self.activitiesList[section].detail
            }
        }
    }

    
    // MARK: - get data from firestore
    func getData(completed: @escaping () -> Void){
        
        let db = Firestore.firestore()
        let activitiesRef = db.collection("Activities")
        
        activitiesRef.getDocuments { snapshot, error in
            if error != nil {
                print("\(error!.localizedDescription)")
            }
            else {
                if let snapshot = snapshot{
                    self.activitiesList = snapshot.documents.map({ doc in
                        return craftsmanship(title: doc["Title"] as? String ?? "",
                                             introduction: doc["Introduction"] as? String ?? "",
                                             detail: doc["Detail"] as? String ?? "")
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
        return activitiesList.count
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

        cell.title?.text = self.activitiesList[indexPath.section].title
        cell.introduction?.text = "Introduction: \n" + self.activitiesList[indexPath.section].introduction
        cell.detailContent = "Detail: \n" + self.activitiesList[indexPath.section].detail
        cell.checkIsFavorite()
        return cell
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
