//
//  HomeScreenVC.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 20/03/23.
//

import UIKit
import SideMenu

class HomeScreenVC: UIViewController {
    
    @IBOutlet var manuView: UIView!
    
    @IBOutlet weak var tableview: UITableView!
    
    var ImageArr:[HomeCellImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manuView.alpha = 0
        dropShadow()
        
        
        //This is Profile name, Location and Post profileImage & PostImage Arrays
        
        let obj1 = HomeCellImage(arrImages: ["Aarav","Aaradhya","Charlotte","Sanjana","Avni","Dharmesh","Meera","Harper"], strUserName: "Dharmesh", strLocation: "Mumbai",strUserImg: "Dharmesh",isLike: false, isBookMark: false, currentpage: 0)
        let obj2 = HomeCellImage(arrImages: ["Nandini","Meera","Kavya","Ishani","Isabella"], strUserName: "Aaradhya", strLocation: "Delhi",strUserImg: "Aaradhya",isLike: false, isBookMark: false, currentpage: 0)
        let obj3 = HomeCellImage(arrImages: ["Akshay","Nandini","Aryabhai","Cute","Modiji","Sanjana","PmModi"], strUserName: "Sanjana", strLocation: "Jaipur",strUserImg: "Sanjana",isLike: false, isBookMark:false , currentpage: 0)
        let obj4 = HomeCellImage(arrImages: ["Aryabhai","Akshay","Cute","Modiji","Sanjana","PmModi"], strUserName: "Harper", strLocation: "Amritsar",strUserImg: "Harper",isLike: false, isBookMark:false, currentpage: 0)
        let obj5 = HomeCellImage(arrImages: ["PmModi","max-andrey","grossgasteiger","Cute","arun-thomas","Akshay","Aryabhai"], strUserName: "Ishani", strLocation: "Banglore",strUserImg: "Ishani",isLike: false, isBookMark: false, currentpage: 0)
        
//        let obj6 = HomeCellImage(arrImages: ["Aarav","Aaradhya","Charlotte","Sanjana","Avni","Dharmesh","Meera","Harper"], strUserName: "Dharmesh", strLocation: "Mumbai",strUserImg: "Dharmesh",isLike: false, isBookMark: false, currentpage: 0)
//        let obj7 = HomeCellImage(arrImages: ["Nandini","Meera","Kavya","Ishani","Isabella"], strUserName: "Aaradhya", strLocation: "Delhi",strUserImg: "Aaradhya",isLike: false, isBookMark: false, currentpage: 0)
//        let obj8 = HomeCellImage(arrImages: ["Akshay","Nandini","Aryabhai","Cute","Modiji","Sanjana","PmModi"], strUserName: "Sanjana", strLocation: "Jaipur",strUserImg: "Sanjana",isLike: false, isBookMark:false , currentpage: 0)
//        let obj9 = HomeCellImage(arrImages: ["Aryabhai","Akshay","Cute","Modiji","Sanjana","PmModi"], strUserName: "Harper", strLocation: "Amritsar",strUserImg: "Harper",isLike: false, isBookMark:false, currentpage: 0)
//        let obj10 = HomeCellImage(arrImages: ["PmModi","max-andrey","grossgasteiger","Cute","arun-thomas","Akshay","Aryabhai"], strUserName: "Ishani", strLocation: "Banglore",strUserImg: "Ishani",isLike: false, isBookMark: false, currentpage: 0)
        
        
        self.ImageArr.append(obj1)
        self.ImageArr.append(obj2)
        self.ImageArr.append(obj3)
        self.ImageArr.append(obj4)
        self.ImageArr.append(obj5)
        
//        self.ImageArr.append(obj6)
//        self.ImageArr.append(obj7)
//        self.ImageArr.append(obj8)
//        self.ImageArr.append(obj9)
//        self.ImageArr.append(obj10)
        
        
    }
    
    func dropShadow() {
        manuView.layer.masksToBounds = false
        manuView.layer.shadowColor = UIColor.black.cgColor
        manuView.layer.shadowOpacity = 0.5
        manuView.layer.shadowOffset = .zero
        manuView.layer.shadowRadius = 5
        manuView.layer.shouldRasterize = true
        
    }
    
    @IBAction func showMnau(_ sender: Any) {
        self.manuView.alpha = 1
        
    }
    
    //like btn
    @IBAction func likeBtnTapped(_ sender: UIButton) {
        
        let obj = self.ImageArr[sender.tag]
        
        if obj.islike == true{
            obj.islike = false
            sender.isSelected = false
//            sender.setImage(UIImage(named:"heart"), for: .normal)
        }else{
            obj.islike = true
            sender.isSelected = true
//            sender.setImage(UIImage(named:"heart (1)"), for: .selected)
        }

        
    }
    @IBAction func commentBtnTapped(_ sender: UIButton) {
    }
    @IBAction func shareBtnTapped(_ sender: UIButton) {
    }
    
    @IBAction func bookmarkBtnTapped(_ sender: UIButton) {
        
        let obj = self.ImageArr[sender.tag]
        if obj.isbookMark == true{
            obj.isbookMark = false
            sender.isSelected = false
//            sender.setImage(UIImage(named:"bookmark"), for: .normal)
        }else
        {
            obj.isbookMark = true
            sender.isSelected = true
//            sender.setImage(UIImage(named:"bookmark (1)"), for: .selected)
        }
        
    }
    
    //Sidebar show and hide buton Action
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
    
    //when we touches anywhere then subview hide if sub opened
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        manuView.alpha = 0
    }
}

//MARK:- Home screen UITableViewDataSource and UITableViewDelegate

extension HomeScreenVC:UITableViewDataSource,UITableViewDelegate{
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Table numberOfRowsInSection:-",section)
        return ImageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as! MyPostTableViewCell
        
        let obj = self.ImageArr[indexPath.row]
        cell.mycollectionview.delegate = self
        cell.mycollectionview.dataSource = self
        cell.mycollectionview.tag = indexPath.row
        cell.mycollectionview.reloadData()
        
        cell.locationLbl.text = obj.strLocation
        cell.userNameLbl.text = obj.strUserName
        cell.likebutton.isSelected = obj.islike
        cell.bookMarkBtn.isSelected = obj.isbookMark
        cell.pageControl.currentPage = obj.currentPageNo
        cell.userProfileImg.image = UIImage(named: obj.strUserImg)
        cell.pageControl.numberOfPages = obj.arrImages.count
        cell.bookMarkBtn.tag = indexPath.row
        cell.likebutton.tag = indexPath.row

//        tableview.reloadRows(at: [indexPath], with: .none)
//        tableview.deleteRows(at: [indexPath], with: .automatic)

        
        return cell
    }
    

}

//MARK:- This is for CollectionView UICollectionViewDelegate,UICollectionViewDataSource

extension HomeScreenVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("collectionView numberOfItemsInSection:-",section)

        return self.ImageArr[collectionView.tag].arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! HomeImageCollectionViewCell
        print("cellForItemAt:-",indexPath.item)

        let obj = self.ImageArr[collectionView.tag]
        cell.homeImages.image = UIImage(named: obj.arrImages[indexPath.item])
        
        return cell
    }
    
    // MARK:- UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("willDisplay cell:-",indexPath.item)
        guard let cellTbl = self.tableview.cellForRow(at: IndexPath(row: collectionView.tag, section: 0)) as? MyPostTableViewCell else {
            return
        }
        self.ImageArr[collectionView.tag].currentPageNo = indexPath.item
        cellTbl.pageControl.currentPage = indexPath.item
        
    }
    
    // MARK: - UICollectionViewDelegate
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
//        let index = scrollView.contentOffset.x / witdh
//        let roundedIndex = round(index)
//
//    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeScreenVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
}
