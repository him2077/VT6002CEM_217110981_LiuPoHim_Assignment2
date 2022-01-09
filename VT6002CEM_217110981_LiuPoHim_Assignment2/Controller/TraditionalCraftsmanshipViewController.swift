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
    
    let test: [String] = ["test1", "test2", "test3"]
    var buildingList = [craftsmanship]()
    var craftsList = [craftsmanship]()
    var foodList = [craftsmanship]()
    var allList = [craftsmanship]()
    var selectedList = [craftsmanship]()
    var cellSpacing : CGFloat = 20
    var selectedRow : String = "All"
    
    
    // MARK: - get data from firestore
    func getData(){
        
        let db = Firestore.firestore()
        let categoryRef = db.collection("Traditional Craftsmanship").document("Category")
        
        categoryRef.collection("Building").getDocuments { snapshot, error in
            if error != nil {
                
            }
            else {
                if let snapshot = snapshot{
                    self.buildingList = snapshot.documents.map({ doc in
                        return craftsmanship(title: doc["Title"] as? String ?? "",
                                             introduction: doc["Introduction"] as? String ?? "",
                                             detail: doc["Detail"] as? String ?? "")
                    })
                    self.allList += self.buildingList
                }
            }
        }
        categoryRef.collection("Crafts").getDocuments { snapshot, error in
            if error != nil {
                
            }
            else {
                if let snapshot = snapshot{
                    self.craftsList = snapshot.documents.map({ doc in
                        return craftsmanship(title: doc["Title"] as? String ?? "",
                                             introduction: doc["Introduction"] as? String ?? "",
                                             detail: doc["Detail"] as? String ?? "")
                    })
                    self.allList += self.craftsList
                }
            }
        }
        categoryRef.collection("Food").getDocuments { snapshot, error in
            if error != nil {
                
            }
            else {
                if let snapshot = snapshot{
                    self.foodList = snapshot.documents.map({ doc in
                        return craftsmanship(title: doc["Title"] as? String ?? "",
                                             introduction: doc["Introduction"] as? String ?? "",
                                             detail: doc["Detail"] as? String ?? "")
                    })
                    self.allList += self.foodList
                }
            }
        }
        selectedList = allList
        tableView.reloadData()
        
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
        cell.introduction?.text = self.selectedList[indexPath.section].introduction
        cell.detail? = self.selectedList[indexPath.section].detail
        cell.checkIsFavorite()
        return cell
    }
    
    // MARK: - main
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        //tableView.register(CustomCell.self, forCellReuseIdentifier: "craftsmanshipCell")
        pickerView.delegate = self
        pickerView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200;
        //tableView.rowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
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
