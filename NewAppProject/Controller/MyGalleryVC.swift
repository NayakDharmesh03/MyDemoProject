//
//  MyGalleryVC.swift
//  NewAppProject
//
//  Created by Bhautik Dudhat on 23/04/23.
//

import UIKit

class MyGalleryVC: UIViewController {

    @IBOutlet weak var mycollectionView: UICollectionView!
    
    var cameraImageArr = ["Darshan","Aarav","Aaradhya","Charlotte","Sanjana","Avni","Dharmesh","Meera","Harper"]
    var recentImageArr = ["Nandini","Meera","Kavya","Ishani","Isabella"]
    var downloadImageArr = ["Nandini","Aryabhai","Akshay","Cute","Modiji","Sanjana","PmModi"]
    var favouriteImageArr = ["Aryabhai","Akshay","Cute","Modiji","Sanjana","PmModi"]

    var allImageArr = ["Darshan",
                       "Olivia",
                       "max-andrey",
                        "Aaradhya",
                        "Aarav",
                        "pexels",
                        "Aditya",
                        "Avni",
                        "arun-thomas",
                        "Charlotte",
                        "Aryabhai",
                        "Akshay",
                        "Cute",
                        "Modiji",
                        "Sanjana",
                        "PmModi",
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
    
    var categoryArr = ["All Image","Recent","Download","Favourite","Camera"]
    
    var galleryArr : [GalleryData] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
            
            let Obj1 = GalleryData(strTitle: "All Image", images: allImageArr)
            let Obj2 = GalleryData(strTitle: "Recent", images: recentImageArr)
            let Obj3 = GalleryData(strTitle: "Camera", images: cameraImageArr)
            let Obj4 = GalleryData(strTitle: "Download", images: downloadImageArr)
            let Obj5 = GalleryData(strTitle: "Favourite", images: favouriteImageArr)
            

            self.galleryArr.append(Obj1)
            self.galleryArr.append(Obj2)
            self.galleryArr.append(Obj3)
            self.galleryArr.append(Obj4)
            self.galleryArr.append(Obj5)

    }
       
    
}
extension MyGalleryVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return galleryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        let cell = mycollectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! MyGalleryCell

        let obj = self.galleryArr[indexPath.row]
    
        cell.myPhoto.image = UIImage(named: obj.imageArr.randomElement() ?? "Emily")
        cell.titleLbel.text = obj.strTitle
        cell.totalImageLbel.text = "\(obj.imageArr.count)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CollectionImageVC") as! CollectionImageVC
        let obj = self.galleryArr[indexPath.row]
        nextVC.gallaryImageArr = self.galleryArr[indexPath.row].imageArr
        nextVC.headerTitle = obj.strTitle
        self.navigationController?.pushViewController(nextVC, animated: true)

    }
    
    //MARK:- For Header title
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerViewIdentifier", for: indexPath) as? CollectionReusableView else {
            fatalError("Unable to dequeue MyHeaderView")
        }
        headerView.titleLabel.text = "My Albums"
        return headerView
    }
    
}
extension MyGalleryVC : UICollectionViewDelegateFlowLayout{
    
    //MARK:- For cell spacing

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (mycollectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

