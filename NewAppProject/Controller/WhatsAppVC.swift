//
//  WhatsAppVC.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 23/04/23.
//

import UIKit
import SideMenu

class WhatsAppVC: UIViewController {

    @IBOutlet var manuView: UIView!
    @IBOutlet var btnFloating: UIButton!
    
    @IBOutlet weak var myGalleryViewContainer: UIView!
    
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet weak var mytableView: UITableView!
    var timeArr = ["14:24","14:33","17:52","Yesterday","Yesterday","Yesterday","Yesterday","25/4/2023","25/4/2023","22/4/2023","22/4/2023","18/4/2023","18/4/2023","17/4/2023","16/4/2023","15/4/2023","12/4/2023","12/4/2023"]
    var contactsName = ["Darshan",
                        "Aaradhya",
                        "Aarav",
                        "Aditya",
                        "Avni",
                        "Charlotte",
                        "Akshay",
                        "Dhara",
                        "Dharmesh",
                        "Divya",
                        "Emma",
                        "Evelyn",
                        "Harper",
                        "Isabella",
                        "Ishani",
                        "Kavya",
                        "Meera",
                        "Nandini"]

    var contactsNo = ["+919281736212",
                      "+918978678992",
                      "+917123423510",
                      "+917280009874",
                      "+919999823823",
                      "+919989092383",
                      "+916681736212",
                      "+919280096254",
                      "+919283346232",
                      "+919281736212",
                      "+919374826445",
                      "+919098789654",
                      "+917878987654",
                      "+918909897867",
                      "+916767898789",
                      "+919087654321",
                      "+919008978909",
                      "+918988882332",]
    
    var isExpanded: Bool = false
    
    var selectedIndex = -1
    
    var isCollapce = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manuView.alpha = 0
        myGalleryViewContainer.alpha = 0
        mytableView.estimatedRowHeight = 121
        mytableView.rowHeight = UITableView.automaticDimension
        
        // Set the text color of the selected segment
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)

        // Set the text color of the unselected segments
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)

    }

    //for status bar color
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
        
        // if also gallery selected then shoiw gallery view
        if segmentControl.selectedSegmentIndex == 1{
            myGalleryViewContainer.alpha = 1
        }
      
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        manuView.alpha = 0
    }
    @IBAction func btnFloatingAction(_ sender: UIButton) {
        
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectedContactsVC") as! SelectedContactsVC
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @IBAction func showmanu(_ sender: UIButton) {
        self.manuView.alpha = 1
    }
    @IBAction func showSideBar(_ sender: Any) {
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
                if UIDevice.current.userInterfaceIdiom == .pad{
                    vc.settings.menuWidth = self.view.frame.width - 200
                }else{
                    vc.settings.menuWidth = self.view.frame.width - 80
                }
                vc.settings.presentationStyle = .viewSlideOut
                vc.settings.statusBarEndAlpha = 0
                vc.leftSide = true
                present(vc, animated: true, completion: nil)
        
    }
   
    
    @IBAction func segmentControler(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1{
            self.titleLbl.text = "Gallery"
            self.myGalleryViewContainer.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {
               
            })
        }else{
            self.myGalleryViewContainer.alpha = 0
            self.titleLbl.text = "WhatsApp"

        }
    }
}

extension WhatsAppVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! contactTableViewCell
        cell.selectionStyle = .none
        cell.namelbl.text = contactsName[indexPath.row]
        cell.phoneNoLbl.text = "Phone \(contactsNo[indexPath.row])"
        cell.timeShowLbl.text = timeArr[indexPath.row]
        cell.profileImage.image = UIImage(named: contactsName[indexPath.row])
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedIndex == indexPath.row && isCollapce == true{
            return 121
        }else{
            return 85
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
         let cell = mytableView.cellForRow(at: indexPath) as! contactTableViewCell
            
//         cell.heartImage.image = UIImage(named: "selectedheart")
//         favouriteCricketer.append(playersName[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedIndex == indexPath.row {
            if self.isCollapce == false {
                cell.showbtn.isSelected = false
              
                self.isCollapce = true
            }else{
                self.isCollapce = false
                cell.showbtn.isSelected = true
            }
        }else{
            self.isCollapce = true
//            cell.showbtn.isSelected = true
        }
        
        self.selectedIndex = indexPath.row
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

