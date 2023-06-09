//
//  SelectedContactsVC.swift
//  NewAppProject
//
//  Created by NT 2 on 12/04/23.
//

import UIKit

class SelectedContactsVC: UIViewController {
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var manuContainerView: UIView!
    @IBOutlet var selectedContactsTbl: UITableView!
    @IBOutlet var searchView: UIView!
    @IBOutlet var manuBtn: UIButton!
    @IBOutlet var countContactsLbl: UILabel!
    
    @IBOutlet var SearchbackBtn: UIButton!
    @IBOutlet var searchBtn: UIButton!
    @IBOutlet var searchbar: UISearchBar!
   
    let data = [
        ["name": "Darshan", "number": "+919281736212"],
        ["name": "Aaradhya", "number": "+919089785634"],
        ["name": "Aarav", "number": "+918281736210"],
        ["name": "Charlotte", "number": "+919997362192"],
        ["name": "Aditya", "number": "+919281736292"],
        ["name": "Dharmesh", "number": "+919281386292"],
        ["name": "Nandini", "number": "+918281736210"],
        ["name": "Kavya", "number": "+917285676213"],
        ["name": "Meera", "number": "+919281739202"],
        ["name": "Harper", "number": "+919980756292"],
        ["name": "Isabella", "number": "+918909907867"],
        ["name": "Dhara", "number": "+917678983423"],
        ["name": "Ishani", "number": "+917868694520"],
        ["name": "Emma", "number": "+919012343212"]
    ]
    
    var filteredData = [[String: String]]()
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        countContactsLbl.text = "\(data.count) contacts"
        searchView.isHidden = true
        manuContainerView.alpha = 0
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        manuContainerView.alpha = 0
    }
    
    @IBAction func searchBackBtnClicked(_ sender: UIButton) {
        self.searchbar.searchTextField.backgroundColor = .white
        searchView.isHidden = true

    }
    @IBAction func backtoContacts(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func manuShow(_ sender: UIButton) {
        manuContainerView.alpha = 1
    }
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        searchView.isHidden = false

    }
    
}
extension SelectedContactsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredData.count : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = selectedContactsTbl.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelectedContactsTableViewCell
        
        let dict = isSearching ? filteredData[indexPath.row] : data[indexPath.row]

        cell.namelbl.text = dict["name"]
        cell.phoneNoLbl.text = "Phone \(String(describing: dict["number"]!))"
        cell.profileImage.image = UIImage(named: dict["name"]! )
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Contacts on Mobile"
        
    }
    
}
extension SelectedContactsVC : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
                filteredData = searchText.isEmpty ? data : data.filter { (dict) -> Bool in
                    
                        let name = dict["name"]!
                        let number = dict["number"]!
                        return name.range(of: searchText, options: .caseInsensitive) != nil ||
                        number.range(of: searchText, options: .caseInsensitive) != nil
                }
                isSearching = !searchText.isEmpty
                selectedContactsTbl.reloadData()
        
        
    
//        if searchText != ""{
//            filtereData = contactsName.filter{
//                $0.contains(searchText)
//            }
//
//            self.selectedContactsTbl.reloadData()
//        }else{
//            print("Kindly enter text")
//            self.filtereData = contactsName
//            self.selectedContactsTbl.reloadData()
//        }
    }
}
