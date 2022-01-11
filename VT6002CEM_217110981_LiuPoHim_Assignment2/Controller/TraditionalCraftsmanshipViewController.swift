//
//  TraditionalCraftsmanshipViewController.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/8/22.
//

import UIKit
import Firebase

class TraditionalCraftsmanshipViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let category = ["All", "Building", "Crafts", "Food"]
    
    var buildingList = [dataStructure]()
    var craftsList = [dataStructure]()
    var foodList = [dataStructure]()
    var allList = [dataStructure]()
    var selectedList = [dataStructure]()
    var cellSpacing : CGFloat = 20
    var selectedRow : String = "All"
    
    
    // MARK: - get data from firestore
    func getData(completed: @escaping () -> Void){
        
        let db = Firestore.firestore()
        let categoryRef = db.collection("Traditional Craftsmanship").document("Category")
        
        categoryRef.collection("Building").getDocuments { snapshot, error in
            if error != nil {
                print("\(error!.localizedDescription)")
            }
            else {
                if let snapshot = snapshot{
                    self.buildingList = snapshot.documents.map({ doc in
                        return dataStructure(title: doc["Title"] as? String ?? "",
                                             introduction: doc["Introduction"] as? String ?? "",
                                             detail: doc["Detail"] as? String ?? "",
                                             location: doc["Location"] as? String ?? "",
                                             latitude: doc["Latitude"] as? Double ?? 0,
                                             longitude: doc["Longitude"] as? Double ?? 0)
                    })
                    self.allList += self.buildingList
                }
            }
        }
        categoryRef.collection("Crafts").getDocuments { snapshot, error in
            if error != nil {
                print("\(error!.localizedDescription)")
            }
            else {
                if let snapshot = snapshot{
                    self.craftsList = snapshot.documents.map({ doc in
                        return dataStructure(title: doc["Title"] as? String ?? "",
                                             introduction: doc["Introduction"] as? String ?? "",
                                             detail: doc["Detail"] as? String ?? "",
                                             location: doc["Location"] as? String ?? "",
                                             latitude: doc["Latitude"] as? Double ?? 0,
                                             longitude: doc["Longitude"] as? Double ?? 0)
                    })
                    self.allList += self.craftsList
                }
            }
        }
        categoryRef.collection("Food").getDocuments { snapshot, error in
            if error != nil {
                print("\(error!.localizedDescription)")
            }
            else {
                if let snapshot = snapshot{
                    self.foodList = snapshot.documents.map({ doc in
                        return dataStructure(title: doc["Title"] as? String ?? "",
                                             introduction: doc["Introduction"] as? String ?? "",
                                             detail: doc["Detail"] as? String ?? "",
                                             location: doc["Location"] as? String ?? "",
                                             latitude: doc["Latitude"] as? Double ?? 0,
                                             longitude: doc["Longitude"] as? Double ?? 0)
                    })
                    self.allList += self.foodList
                }
                self.selectedList = self.allList
                completed()
            }
        }

    }
    
    
    // MARK: - table view setting
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedList.count
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
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "craftsmanshipCell") as! CustomCell
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true

        cell.title?.text = self.selectedList[indexPath.section].title
        cell.introduction?.text = "Introduction: \n" + self.selectedList[indexPath.section].introduction.replacingOccurrences(of: "\\n", with: "\n")
        cell.detailContent = "Detail: \n" + self.selectedList[indexPath.section].detail.replacingOccurrences(of: "\\n", with: "\n")
        cell.checkIsFavorite()
        return cell
    }
        
    
    
    // MARK: - main
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!

       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.register(CustomCell.self, forCellReuseIdentifier: "craftsmanshipCell")
        pickerView.delegate = self
        pickerView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200;
        //tableView.rowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        getData{ () -> () in
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let section = indexPath.section
                destination.titleContent = self.selectedList[section].title
                destination.introductionContent = self.selectedList[section].introduction.replacingOccurrences(of: "\\n", with: "\n")
                destination.detailContent = self.selectedList[section].detail.replacingOccurrences(of: "\\n", with: "\n")
            }
        }
    }
    
    // MARK: - picker view setting
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = category[row]
        switch selectedRow{
        case "All":
            selectedList = allList
        case "Building":
            selectedList = buildingList
        case "Crafts":
            selectedList = craftsList
        case "Food":
            selectedList = foodList
        default:
            selectedList = allList
        }
        tableView.reloadData()
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
