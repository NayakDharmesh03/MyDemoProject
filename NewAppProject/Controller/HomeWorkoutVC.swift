//
//  HomeWorkoutVC.swift
//  NewAppProject
//
//  Created by NT 2 on 12/04/23.
//

import UIKit
import SideMenu

class HomeWorkoutVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var manuView: UIView!
    let viewcolors = [UIColor.yellow, UIColor.red,UIColor.green, UIColor.blue,UIColor.yellow, UIColor.red,UIColor.green, UIColor.blue,UIColor.green, UIColor.blue]

    //var DataArr:[HomeWorkoutCellData] = []
    var DataArr = [
        HomeWorkoutCellData(sliderValue: 2, labelText: " 0.2", isSliderEnabled: true, switchIsOn: true, progressValue: 2),
        HomeWorkoutCellData(sliderValue: 5, labelText: "0.5", isSliderEnabled: false, switchIsOn: false, progressValue: 5),
        HomeWorkoutCellData(sliderValue: 8, labelText: "0.8", isSliderEnabled: true, switchIsOn: true, progressValue: 8),
        HomeWorkoutCellData(sliderValue: 2, labelText: "Value: 0.2", isSliderEnabled: true, switchIsOn: true, progressValue: 2),
        HomeWorkoutCellData(sliderValue: 5, labelText: "Value: 0.5", isSliderEnabled: false, switchIsOn: false, progressValue: 5),
        HomeWorkoutCellData(sliderValue: 8, labelText: "Value: 0.8", isSliderEnabled: true, switchIsOn: true, progressValue: 8),
        HomeWorkoutCellData(sliderValue: 2, labelText: "Value: 0.2", isSliderEnabled: true, switchIsOn: true, progressValue: 2),
        HomeWorkoutCellData(sliderValue: 5, labelText: "Value: 0.5", isSliderEnabled: false, switchIsOn: false, progressValue: 5),
        HomeWorkoutCellData(sliderValue: 8, labelText: "Value: 0.8", isSliderEnabled: true, switchIsOn: true, progressValue: 8),
        HomeWorkoutCellData(sliderValue: 2, labelText: "Value: 0.2", isSliderEnabled: true, switchIsOn: true, progressValue: 2),
        HomeWorkoutCellData(sliderValue: 5, labelText: "Value: 0.5", isSliderEnabled: false, switchIsOn: false, progressValue: 5),
        HomeWorkoutCellData(sliderValue: 8, labelText: "Value: 0.8", isSliderEnabled: true, switchIsOn: true, progressValue: 8)
       ]
    var ExerciseNames = ["Running",
                         "Stretching",
                         "Push-Ups",
                         "Pull-ups"
                        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        dropShadow()
        self.manuView.alpha = 0
        
     
//
//        let obj1 = HomeWorkoutCellData(arrcolor: viewcolors, exerciseName: "Running", exercise: "exercise", sliderValue: 0, onSwitch: false, Star1: 1, Star2: 2, Star3: 3, enableSlider: false)
//        let obj2 = HomeWorkoutCellData(arrcolor: viewcolors, exerciseName: "Running", exercise: "exercise", sliderValue: 0, onSwitch: false, Star1: 1, Star2: 2, Star3: 3, enableSlider: false)
//        let obj3 = HomeWorkoutCellData(arrcolor: viewcolors, exerciseName: "Running", exercise: "exercise", sliderValue: 0, onSwitch: false, Star1: 1, Star2: 2, Star3: 3, enableSlider: false)
//        let obj4 = HomeWorkoutCellData(arrcolor: viewcolors, exerciseName: "Running", exercise: "exercise", sliderValue: 0, onSwitch: false, Star1: 1, Star2: 2, Star3: 3, enableSlider: false)
//        let obj5 = HomeWorkoutCellData(arrcolor: viewcolors, exerciseName: "Running", exercise: "exercise", sliderValue: 0, onSwitch: false, Star1: 1, Star2: 2, Star3: 3, enableSlider: false)
//        let obj6 = HomeWorkoutCellData(arrcolor: viewcolors, exerciseName: "Running", exercise: "exercise", sliderValue: 0, onSwitch: false, Star1: 1, Star2: 2, Star3: 3, enableSlider: false)
//        let obj7 = HomeWorkoutCellData(arrcolor: viewcolors, exerciseName: "Running", exercise: "exercise", sliderValue: 0, onSwitch: false, Star1: 1, Star2: 2, Star3: 3, enableSlider: false)
//        let obj8 = HomeWorkoutCellData(arrcolor: viewcolors, exerciseName: "Running", exercise: "exercise", sliderValue: 0, onSwitch: false, Star1: 1, Star2: 2, Star3: 3, enableSlider: false)
//        let obj9 = HomeWorkoutCellData(arrcolor: viewcolors, exerciseName: "Running", exercise: "exercise", sliderValue: 0, onSwitch: false, Star1: 1, Star2: 2, Star3: 3, enableSlider: false)
//        let obj10 = HomeWorkoutCellData(arrcolor: viewcolors, exerciseName: "Running", exercise: "exercise", sliderValue: 0, onSwitch: false, Star1: 1, Star2: 2, Star3: 3, enableSlider: false)
//
//        self.DataArr.append(obj1)
//        self.DataArr.append(obj2)
//        self.DataArr.append(obj3)
//        self.DataArr.append(obj4)
//        self.DataArr.append(obj5)
//        self.DataArr.append(obj6)
//        self.DataArr.append(obj7)
//        self.DataArr.append(obj8)
//        self.DataArr.append(obj9)
//        self.DataArr.append(obj10)

    }
    
    
    
    
    func dropShadow() {
        manuView.layer.masksToBounds = false
        manuView.layer.shadowColor = UIColor.black.cgColor
        manuView.layer.shadowOpacity = 0.5
        manuView.layer.shadowOffset = .zero
        manuView.layer.shadowRadius = 5
        manuView.layer.shouldRasterize = true

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
    
    
    
    //MARK:- Star ratting buttons Action
    
    @IBAction func starRattingAction(_ sender: UIButton) {
        
        let obj = self.DataArr[sender.tag]
        
        
      
//        if sender.tag == 1{
//            if star2.isSelected || star3.isSelected{
//                star2.isSelected = false
//                star3.isSelected = false
//                return
//            }
//            sender.isSelected = true
//        }else if sender.tag == 2{
//            if star3.isSelected{
//                star3.isSelected = false
//                return
//            }
//            star1.isSelected = true
//            star2.isSelected = true
//        }else if sender.tag == 3{
//
//            star1.isSelected = true
//            star2.isSelected = true
//            star3.isSelected = true
//
//        }
    }
    
    //MARK:- Switch Action

    @IBAction func switchAction(_ sender: UISwitch) {
//        let obj = self.DataArr[sender.tag]
//
//        if obj.isOnSwitch {
//            obj.isEnableSlider = false
//            obj.isOnSwitch = false
//            sender.isOn = false
//
//        }else{
//            obj.isOnSwitch = true
//            obj.isEnableSlider = true
//            sender.isOn = true
//        }
        /*
         if `switch`.isOn{
             Slider.isEnabled = true
             star1.isEnabled = true
             star2.isEnabled = true
             star3.isEnabled = true

         }else{
             star1.isEnabled = false
             star2.isEnabled = false
             star3.isEnabled = false

             Slider.isEnabled = false

         }
         */
    }
    
    
    //MARK:- Slider Action --------
    
    @IBAction func sliderAction(_ sender: UISlider) {
//        let value = sender.value
//        let point = sender.convert(CGPoint.zero, to: tableView)
//            guard let indexPath = tableView.indexPathForRow(at: point) else { return }
//            var model = DataArr[indexPath.row]
//        model.sliderValue = Int(value)
//            tableView.reloadRows(at: [indexPath], with: .none)
//        let obj = self.DataArr[sender.tag]
//
//        let value = Int(obj.strSliderValue)
//
//        obj.strSliderValue = value
        
        /*
         
         let value = Int(Slider.value)
     progressCurrentValue.text = "\(value)"
     progressBar.progress = sender.value / sender.maximumValue

     sliderValu.text = "\(value) /\(sliderMaxvalue)"
     
     coloreView.alpha = CGFloat(sender.value)
         */
        

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.manuView.alpha = 0
    }
    @IBAction func showMnau(_ sender: UIButton) {
        self.manuView.alpha = 1
    }
 
}
extension HomeWorkoutVC : UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeWorkoutTableViewCell
        
       
        let cellModel = DataArr[indexPath.row]

        cell.Slider.value = Float(cellModel.sliderValue)
                cell.sliderValu.text = cellModel.labelText
                cell.Slider.isEnabled = cellModel.isSliderEnabled
                cell.`switch`.isOn = cellModel.switchIsOn
        cell.progressBar.progress = Float(cellModel.progressValue)

                cell.sliderValueChanged = { value in
                    cell.sliderValu.text = "Value: \(value)"
                    if let index = tableView.indexPath(for: cell) {
                        var updatedModel = self.DataArr[index.row]
                        updatedModel.sliderValue = Int(value)
                        updatedModel.progressValue = Int(value)
                        self.DataArr[index.row] = updatedModel
                        tableView.reloadRows(at: [index], with: .none)
                    }
                }

                cell.switchValueChanged = { isOn in
                    if let index = tableView.indexPath(for: cell) {
                        var updatedModel = self.DataArr[index.row]
                        updatedModel.isSliderEnabled = isOn
                        updatedModel.switchIsOn = isOn
                        self.DataArr[index.row] = updatedModel
                        tableView.reloadRows(at: [index], with: .none)
                    }
                }

                return cell
            }


}
