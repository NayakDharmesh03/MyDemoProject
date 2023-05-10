//
//  ChangePasswordVC.swift
//  NewAppProject
//
//  Created by NT 2 on 20/03/23.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet var popupVIew: UIView!
    @IBOutlet var oldPasswordTF: UITextField!
    @IBOutlet var newPasswordTF: UITextField!
    @IBOutlet var conformPasswordTF: UITextField!
    @IBOutlet var updatePasswordBtn: UIButton!
    var user_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        popupVIew.alpha = 0
        updatePasswordBtn.layer.cornerRadius = 20
        textFieldDesign()
        dropShadow()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewWillAppear(true)
        popupVIew.alpha = 1
    }
    func textFieldDesign(){
        
        oldPasswordTF.setBottomBorder(color: "#3EFE46")
        conformPasswordTF.setBottomBorder(color: "#3EFE46")
        newPasswordTF.setBottomBorder(color: "#3EFE46")
    }
    
    //MARK:- receiving userdata from userdefault
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getData()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
    // MARK:- Update Password Btn Clicked Mathod
    
    @IBAction func updatePasswordBtnClicked(_ sender: UIButton) {
        
        
        
        let oldpassResult = DataBaseManager.shared.matchOldPassword(userId: self.user_id, strOldPass: oldPasswordTF.text!)
                
        if oldPasswordTF.text == "" && newPasswordTF.text == "" && conformPasswordTF.text == ""
        {
            self.createAlert(strAlert: "Please fill Data")
        }else if oldpassResult == false  {
            createAlert(strAlert: "OldPassword Not match...")
        }
        else if newPasswordTF.text == ""{
            self.createAlert(strAlert: "Please enter new Password")
        }else if conformPasswordTF.text == ""{
            self.createAlert(strAlert: "Please enter conformpassword")
        }
        else if newPasswordTF.text != conformPasswordTF.text{
            createAlert(strAlert: "Conform Password Not match")
        }
        else{
            
            
            
            
            
                //createAlertAndNavigate(strAlert: "Password Updated successufully")
            if oldpassResult != false{
                let result = DataBaseManager.shared.chageUserPassword(userId: self.user_id, strOldPass: oldPasswordTF.text!, strNewPass: newPasswordTF.text!)
                if result == true{
                    self.dismiss(animated: true, completion: nil)
                }
            }else{
                createAlert(strAlert: "OldPassword Not match...")
            }
           
               
        }

    }
    
}
extension ChangePasswordVC:UITextFieldDelegate{
    
    //maximum password charactor or data in textfield delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            //maximum character in password
            let updateText = currentText.replacingCharacters(in: stringRange, with: string)
            
            return updateText.count <= 8
    }
}
//MARK:- Loader code (Activity indicator)
extension Login{
    
    func loader2()->UIAlertController{
        let alert = UIAlertController(title: " Fetching your email...", message: "Loading...", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 5, y: 10, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.startAnimating()
        alert.view.addSubview(indicator)
        present(alert, animated: true, completion: nil)
        return alert
        
    }
    
    func stopLoad2(loader:UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}
extension ChangePasswordVC{
    
    // MARK:- shadow of popup view
    
    func dropShadow() {
        popupVIew.layer.cornerRadius = 25
        popupVIew.layer.masksToBounds = false
        popupVIew.layer.shadowColor = UIColor.black.cgColor
        popupVIew.layer.shadowOpacity = 0.9
        popupVIew.layer.shadowOffset = .zero
        popupVIew.layer.shadowRadius = 5
        popupVIew.layer.shouldRasterize = true
    }
    
    // MARK:- UserDefault data filled in Textfields here.
    
            func getData(){
                getDataFromDefaults { success, id, firstname, lastname, email, password, mobileno,dateofbirth,birthtime,country,state,city,gender,aboutme,imgUrl  in
                    
                            if success == true {
//                                self.obj.passwordTextField.text = password
                                self.user_id = id
                            }else {
                                //No data found
                            }
               }
          }
    
}
