//
//  SignUpTableViewController.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 07/03/23.
//

import UIKit

protocol DatePickerDelegate: class {
    func datePickerValueChanged(date: Date)
}


class SignUpTableViewController: UITableViewController{
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var cameraBtn: UIButton!
    
    @IBOutlet var maleBtn: UIButton!
    @IBOutlet var femaleBtn: UIButton!
    
    @IBOutlet weak var signUpTitle: UILabel!
    @IBOutlet weak var firstnameTextFied: UITextField!
    @IBOutlet weak var lastnameTextFied: UITextField!
    @IBOutlet weak var emailTextFied: UITextField!
    @IBOutlet weak var passwordTextFied: UITextField!
    @IBOutlet weak var mobileTextFied: UITextField!
    
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var birthTimeTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    
    var gender:String = ""
    let placeholder = "About Me"
    
    @IBOutlet weak var aboutmeTV: UITextView!
    
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    
    var selectedImg = false
    let datePicker1 = UIDatePicker() //for Date selecting
    let datePicker2 = UIDatePicker() //for time selecting
    
    let countryPicker = UIPickerView()
    let statePicker = UIPickerView()
    let cityPicker = UIPickerView()
    
    //editProfile viewController obj
    let editVC = EditProfileData()
    
    let countriesArr = ["India", "USA", "UK"]
    
    let statesArr = [
        "India": ["Andhra Pradesh", "Maharashtra", "Gujarat"],
        "USA": ["California", "Texas", "Florida"],
        "UK": ["England", "Scotland", "Wales"]
    ]
    let citiesArr = [
        "Andhra Pradesh": ["Visakhapatnam", "Vijayawada", "Guntur", "Nellore", "Kurnool"],
        "Maharashtra": ["Mumbai", "Pune", "Nagpur", "Nashik", "Aurangabad"],
        "Gujarat": ["Ahmedabad", "Surat", "Vadodara", "Rajkot", "Bhavnagar"],
        
        "California": ["Los Angeles", "San Francisco", "San Diego", "San Jose", "Fresno"],
        "Texas": ["Houston", "San Antonio", "Dallas", "Austin", "Fort Worth"],
        "Florida": ["Miami", "Orlando", "Jacksonville", "Tampa", "St. Petersburg"],
        
        "England": ["London", "Manchester", "Birmingham", "Liverpool", "Leeds"],
        "Scotland": ["Edinburgh", "Glasgow", "Aberdeen", "Dundee", "Inverness"],
        "Wales": ["Cardiff", "Swansea", "Newport", "Bangor", "St. Asaph"]
    ]
    
    var selectedCountryIndex = 0
    var selectedStateIndex = 0
    var selectedCityIndex = 0
    
    var selectedCountry = ""
    var selectedState = ""
    var selectedCity = ""
    
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        mobileTextFied.maxLength = 10
        
        
        aboutmeTV.text = placeholder
        aboutmeTV.textColor = .gray
        openTimeDatePicker()
        openDateDatePicker()
        
        userTappedOnImage()
        allControlsConfiguration()
        
        countryTF.setUpImage(imageName: "arrowtriangle.down.fill", on: .right)
        stateTF.setUpImage(imageName: "arrowtriangle.down.fill", on: .right)
        cityTF.setUpImage(imageName: "arrowtriangle.down.fill", on: .right)
        
        
        countryPicker.dataSource = self
        countryPicker.delegate = self
        
        statePicker.dataSource = self
        statePicker.delegate = self
        
        cityPicker.dataSource = self
        cityPicker.delegate = self
        
        
    }
    
    
    @IBAction func openCamera(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
//MARK:- Open Gallery
    func userTappedOnImage(){
        
        //------
        let picker = UIImagePickerController()
            picker.delegate = self
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
                action in
                
                picker.sourceType = .camera
                self.present(picker, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
                action in
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        //--------
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openGallary(tapGestureRecognizer:)))
        profileImage.addGestureRecognizer(tapGesture)
    }
    
    
    
    //MARK:- Back Button code
    @IBAction func backButtonClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func radioButtonsClicked(_ sender: UIButton) {
        
        if sender.tag == 1{
            maleBtn.isSelected = true
            femaleBtn.isSelected = false
            
            self.gender = "Male"
            print("Male")
        }
        else if sender.tag == 2{
            maleBtn.isSelected = false
            femaleBtn.isSelected = true
            self.gender = "Female"
            print("Female")
        }
        
    }
    
    
    //MARK:- SignIn Button code
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK:- Create Account code
    @IBAction func createAccountBtnClicked(_ sender: UIButton) {
        
        let imgSystem = UIImage(systemName: "person.crop.circle")
        
        if profileImage.image?.pngData() == imgSystem?.pngData() && firstnameTextFied.text == "" && lastnameTextFied.text == "" && mobileTextFied.text == "" && dobTF.text == "" && birthTimeTF.text == "" && countryTF.text == "" && stateTF.text == "" && cityTF.text == ""{
            self.createAlert(strAlert: "Please fill All Data")
            
        }
        else if profileImage.image?.pngData() == imgSystem?.pngData(){
            self.createAlert(strAlert: "please set Profile image")
        }
        else if(firstnameTextFied.text == ""){
            self.createAlert(strAlert: "Please enter name first")
        }else if(lastnameTextFied.text == ""){
            self.createAlert(strAlert: "Please enter lastname")
        }
        else if emailTextFied.text == ""{
            self.createAlert(strAlert: "Please enter email")
        }else if isValidEmail(testStr: emailTextFied.text!) ==  false
        {
            self.createAlert(strAlert: "Please Enter Valid email")
        }
        else if passwordTextFied.text == ""{
            self.createAlert(strAlert: "Please enter password")
        }
        else if isValidPassword(testStr: passwordTextFied.text!) == false{
            self.createAlert(strAlert: "Password must be at least 6 letter")
        }
        else if mobileTextFied.text == ""{
            self.createAlert(strAlert: "Please enter mobile number")
        }else if isValidPhone(testStr: mobileTextFied.text!) == false{
            
            self.createAlert(strAlert: "Please Enter Valid phone")
            
        }
        else if dobTF.text == ""{
            self.createAlert(strAlert: "Please enter date of birth")
            
        }
        else if birthTimeTF.text == ""{
            self.createAlert(strAlert: "Please enter BirthTime")
            
        }
        else if countryTF.text == "" {
            self.createAlert(strAlert: "please select Coutry")
        }
        else if stateTF.text == "" {
            self.createAlert(strAlert: "please select state")
        }
        else if cityTF.text == "" {
            self.createAlert(strAlert: "please select city")
        }
        else if !maleBtn.isSelected  && !femaleBtn.isSelected {
            self.createAlert(strAlert: "please select gender")
        }
        else if aboutmeTV.text == "About Me"{
            self.createAlert(strAlert: "please enter about me")
        }
        else
        {
            let userExist = DataBaseManager.shared.checkUserEmailisExitOrNot(strEmail: emailTextFied.text!)
            
            if !userExist{
                self.saveProfileImage
                { success,Message in
                    
                    if success == true{
                        
                        DataBaseManager.shared.signUpUser(strfirstname: self.firstnameTextFied.text!, strlastname: self.lastnameTextFied.text!, stremail: self.emailTextFied.text!, strpassword: self.passwordTextFied.text!, strmobile: self.mobileTextFied.text!, strdateofbirth: self.dobTF.text!, strbirthtime: self.birthTimeTF.text!, strcountry: self.countryTF.text!, strstate: self.stateTF.text!, strcity: self.cityTF.text!, strgender:self.gender, straboutme: self.aboutmeTV.text!, strImgUrl: Message)
                        { (success, msg) in
                            
                            if success == true{
                                print("Data Added succsessFlly")
                            }
                            else{
                                print("Error")
                            }
                        }
                        
                    }
                }
                self.navigationController?.popViewController(animated: true)
                
            }else{
                emailTextFied.text = ""
                createAlert(strAlert: "This user email are allready registered")
            }
        }
    }
    
}
extension SignUpTableViewController {
    
    //MARK:- Save Profile image in Documents
    
    func saveProfileImage(completion:@escaping (Bool,String)->()){
        
        if  let image = profileImage.image {
            
            let imageName = "img" + "\(Date().timeIntervalSince1970)" + ".png"
            
            let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent(imageName)
            
            let fullDestPathString = fullDestPath!.path
            
            if !FileManager.default.fileExists(atPath: fullDestPath!.path){
                do{
                    try image.pngData()!.write(to: fullDestPath!)
                    print("Image Added Successfully")
                    completion(true, fullDestPathString)
                    
                }catch{
                    print("Image Not Added")
                    completion(false, "")
                }
            }else {
                
                print("Image Not exist")
                completion(false, "")
            }
        }
    }
    
}
//MARK:- Profile image set
extension SignUpTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @objc func openGallary(tapGestureRecognizer: UITapGestureRecognizer){
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            
            let pickerview = UIImagePickerController()
            pickerview.delegate = self
            pickerview.sourceType = .savedPhotosAlbum
            present(pickerview, animated: true)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.profileImage.image = image
            self.selectedImg = true
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}


//MARK:- TextField Delegates

extension SignUpTableViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        return true
    }
    
    //maximum charactor or data in textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //This is for email text in lowercase
        if textField.tag == 3{
            // Convert the replacement string to lowercase
            let lowerCaseString = string.lowercased()
            
            // Create a new string by replacing the entered text with the lowercase string
            let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: lowerCaseString)
            
            // Update the text field with the new string
            textField.text = newString
            // Return false to prevent the default behavior of the text field
            return false
            
        }else{
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            
            let updateText = currentText.replacingCharacters(in: stringRange, with: string)
            
            if textField.tag == 5{
                return updateText.count <= 10
            }else if textField.tag == 4{
                return updateText.count <= 8
            }else if(textField.tag == 1){
                return updateText.count <= 24
            }else if(textField.tag == 2){
                return updateText.count <= 24
            }
            
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 6{ //birthDate picker open
            openDateDatePicker()
        }else if textField.tag == 7{ //birth time picker open
            openTimeDatePicker()
        }
        else if textField.tag == 8{
            //country list
            openPickerViewList()
        }else if textField.tag == 9{
            
            if countryTF.text == ""{
                createAlert(strAlert: "First select Country")
            }else{
                //state list
                openStatePickerViewList()
            }
            
        }else if textField.tag == 10{
            if countryTF.text == "" && stateTF.text == ""{
                createAlert(strAlert: "First select Country & State")
            }else if stateTF.text == "" {
                createAlert(strAlert: "First select State")
            }else{
                //City list
                openCityPickerViewList()
            }
            
            
        }
    }
}


extension SignUpTableViewController: UITextViewDelegate{
    
    func allControlsConfiguration(){
        
        cameraBtn.layer.masksToBounds = true
        cameraBtn.layer.cornerRadius =  cameraBtn.frame.height/2
        cameraBtn.layer.borderWidth = 1
        cameraBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius =  profileImage.frame.height/2
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        
        firstnameTextFied.layer.cornerRadius = firstnameTextFied.frame.height/2
        firstnameTextFied.layer.masksToBounds = true
        firstnameTextFied.layer.borderWidth = 1
        firstnameTextFied.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        
        lastnameTextFied.layer.cornerRadius = lastnameTextFied.frame.height/2
        lastnameTextFied.layer.masksToBounds = true
        lastnameTextFied.layer.borderWidth = 1
        lastnameTextFied.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        
        emailTextFied.layer.cornerRadius = emailTextFied.frame.height/2
        emailTextFied.layer.masksToBounds = true
        emailTextFied.layer.borderWidth = 1
        emailTextFied.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        
        
        passwordTextFied.layer.cornerRadius = passwordTextFied.frame.height/2
        passwordTextFied.layer.masksToBounds = true
        passwordTextFied.layer.borderWidth = 1
        passwordTextFied.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        
        mobileTextFied.layer.cornerRadius = mobileTextFied.frame.height/2
        mobileTextFied.layer.masksToBounds = true
        mobileTextFied.layer.borderWidth = 1
        mobileTextFied.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        
        dobTF.layer.cornerRadius = dobTF.frame.height/2
        dobTF.layer.masksToBounds = true
        dobTF.layer.borderWidth = 1
        dobTF.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        dobTF.layer.cornerRadius = dobTF.frame.height/2
        
        birthTimeTF.layer.masksToBounds = true
        birthTimeTF.layer.borderWidth = 1
        birthTimeTF.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        birthTimeTF.layer.cornerRadius = birthTimeTF.frame.height/2
        
        countryTF.layer.masksToBounds = true
        countryTF.layer.borderWidth = 1
        countryTF.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        countryTF.layer.cornerRadius = countryTF.frame.height/2
        
        stateTF.layer.masksToBounds = true
        stateTF.layer.borderWidth = 1
        stateTF.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        stateTF.layer.cornerRadius = stateTF.frame.height/2
        
        cityTF.layer.masksToBounds = true
        cityTF.layer.borderWidth = 1
        cityTF.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        cityTF.layer.cornerRadius = cityTF.frame.height/2
        
        aboutmeTV.layer.cornerRadius = 20
        aboutmeTV.layer.masksToBounds = true
        aboutmeTV.layer.borderWidth = 1
        aboutmeTV.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
        
        createAccountBtn.layer.cornerRadius = createAccountBtn.frame.height/2
        createAccountBtn.layer.masksToBounds = true
        createAccountBtn.layer.borderWidth = 1
        createAccountBtn.layer.borderColor = #colorLiteral(red: 0.6509079337, green: 0.6510220766, blue: 0.6509007215, alpha: 1)
    }
    
    // UITextViewDelegate method called when the text view is selected
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if aboutmeTV.textColor == .gray && aboutmeTV.text == placeholder {
            aboutmeTV.text = ""
            aboutmeTV.textColor = .black
        }
    }
    
    // UITextViewDelegate method called when the text view is deselected
    func textViewDidEndEditing(_ textView: UITextView) {
        if aboutmeTV.text.isEmpty {
            aboutmeTV.text = placeholder
            aboutmeTV.textColor = .gray
        }
    }
}
extension SignUpTableViewController {
    
    
    //MARK:- For Date selecting
    func openDateDatePicker(){
        
        datePicker1.preferredDatePickerStyle = .wheels
        datePicker1.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        dobTF.inputView = datePicker1
        datePicker1.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDateBtnClicked))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        
        
        toolBar.items = [cancelBtn,flexibleBtn,doneBtn]
        dobTF.inputAccessoryView = toolBar
        
    }
    
    @objc func doneDateBtnClicked(){
        //this is for selected date pass in edit Profile screen
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dobTF.text = formatter.string(from: datePicker1.date)
        self.view.endEditing(true)
    }
    
    //MARK:- For Time selecting Date picker
    
    func openTimeDatePicker(){
        datePicker2.preferredDatePickerStyle = .wheels
        birthTimeTF.inputView = datePicker2
        datePicker2.datePickerMode = .time
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClicked))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [cancelBtn,flexibleBtn,doneBtn]
        birthTimeTF.inputAccessoryView = toolBar
        
    }
    
    @objc func doneBtnClicked(){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        
        formatter.timeStyle = .medium
        birthTimeTF.text = formatter.string(from: datePicker2.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelBtnClicked(){
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
    
}

//MARK:- UIPicker list For Select Country,State,City
extension SignUpTableViewController {
    
    func openCountryListData(){
        
        let toolBar = UIToolbar()
        countryPicker.showsSelectionIndicator = true
        countryTF.inputView = countryPicker
        toolBar.sizeToFit()
        
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClick))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(coutrycancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [cancelBtn,flexibleBtn,doneBtn]
        
        countryTF.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonClick(){
        let selectedItem = countriesArr[countryPicker.selectedRow(inComponent: 0)]
        countryTF.text = selectedItem
        countryTF.endEditing(true)
    }
    
//    @objc func coutrycancelBtnClicked(){
//        self.view.endEditing(true)
//        self.resignFirstResponder()
//    }
    
}




//MARK:- UIPicker DataSource and Delegate
extension SignUpTableViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    // MARK: - UIPickerViewDelegate methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == countryPicker {
            return countriesArr[row]
        } else if pickerView == statePicker {
            let country = countriesArr[selectedCountryIndex]
            let state = statesArr[country]![row]
            return state
        } else {
            let country = countriesArr[selectedCountryIndex]
            let state = statesArr[country]![selectedStateIndex]
            let city = citiesArr[state]![row]
            return city
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == countryPicker {
            selectedCountryIndex = row
            selectedStateIndex = 0
            selectedCityIndex = 0
            statePicker.reloadAllComponents()
            cityPicker.reloadAllComponents()
            
        } else if pickerView == statePicker {
            selectedStateIndex = row
            selectedCityIndex = 0
            cityPicker.reloadAllComponents()
        } else {
            selectedCityIndex = row
        }
    }
    
    // MARK: - UIPickerViewDataSource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == countryPicker {
            return countriesArr.count
        } else if pickerView == statePicker {
            let country = countriesArr[selectedCountryIndex]
            let statesInCountry = statesArr[country]!
            return statesInCountry.count
        } else {
            let country = countriesArr[selectedCountryIndex]
            let state = statesArr[country]![selectedStateIndex]
            let citiesInState = citiesArr[state]!
            return citiesInState.count
        }
    }
}

//MARK:- Coutry Picker
extension SignUpTableViewController{
    
    func openPickerViewList(){
        
        countryTF.inputView = countryPicker
    
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))

        
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(coutrycancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [cancelBtn,flexibleBtn,doneBtn]
        
        
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
//        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
//
        countryTF.inputAccessoryView = toolbar
 
    }
    
    @objc func doneButtonTapped() {
        
        let country = countriesArr[selectedCountryIndex]
        if country != countryTF.text{
            stateTF.text = ""
            cityTF.text = ""
        }else if stateTF.text == ""{
            //state & city does not select first select country
        }
        countryTF.text = country
        selectedCountry = country
        
        
        countryTF.resignFirstResponder()
  
    }
    
    @objc func coutrycancelBtnClicked(){
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
}

//MARK:- State Picker
extension SignUpTableViewController{
    
    func openStatePickerViewList(){
        
        stateTF.inputView = statePicker
        
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneStateButtonTapped))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(stateCancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [cancelBtn,flexibleBtn,doneBtn]
        stateTF.inputAccessoryView = toolbar
    }
    
    @objc func doneStateButtonTapped() {
        
        let state = statesArr[selectedCountry]![selectedStateIndex]
        
        if state != stateTF.text{
            cityTF.text = ""
        }else if stateTF.text == ""{
            //city does not select
        }
        stateTF.text = state
        selectedState = state
        
        stateTF.resignFirstResponder()
    }
    
    @objc func stateCancelBtnClicked(){
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
}

//MARK:- City Picker
extension SignUpTableViewController{
    
    func openCityPickerViewList(){
        
        cityTF.inputView = cityPicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneCityButtonTapped))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cityCancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [cancelBtn,flexibleBtn,doneBtn]
        cityTF.inputAccessoryView = toolbar
    }
    
    @objc func doneCityButtonTapped() {
        
        let city = citiesArr[selectedState]![selectedCityIndex]
        cityTF.text = city
        cityTF.resignFirstResponder()
    }
    
    @objc func cityCancelBtnClicked(){
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
}
