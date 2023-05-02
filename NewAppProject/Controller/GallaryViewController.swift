//
//  GallaryViewController.swift
//  NewAppProject
//
//  Created by NT 2 on 12/04/23.
//

import UIKit

class GallaryViewController: UIViewController {

    @IBOutlet var galleryCollectionView: UICollectionView!
    
    var myPhotos = ["peakpx1","peakpx2","peakpx3","peakpx4","peakpx5","peakpx6"]
    
    var categoryArr = ["All Image","Recent","Download","Favourite","Camera"]
    
    var galleryArr : [GalleryData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Obj1 = GalleryData(strTitle: "All Image", images: myPhotos)
        let Obj2 = GalleryData(strTitle: "Recent", images: myPhotos)
        let Obj3 = GalleryData(strTitle: "Download", images: myPhotos)
        let Obj4 = GalleryData(strTitle: "Favourite", images: myPhotos)
        let Obj5 = GalleryData(strTitle: "Camera", images: myPhotos)


        self.galleryArr.append(Obj1)
        self.galleryArr.append(Obj2)
        self.galleryArr.append(Obj3)
        self.galleryArr.append(Obj4)
        self.galleryArr.append(Obj5)

    }
   
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }

}

extension GallaryViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let gCell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCollectionViewCell
        let obj = self.galleryArr[indexPath.row]
        
        gCell.photos.image = UIImage(named: obj.imageArr.randomElement() ?? "Emily")
        gCell.titleLabel.text = obj.strTitle
        gCell.totalImageLabel.text = "\(obj.imageArr.count)"
        
        return gCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCollectionIMG") as! CollectionImageVC
        let obj = self.galleryArr[indexPath.row]
        nextVC.gallaryImageArr = self.galleryArr[indexPath.row].imageArr
        nextVC.headerTitle = obj.strTitle
        self.navigationController?.pushViewController(nextVC, animated: true)

    }
    
    //MARK:- For Header title
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerTitle", for: indexPath) as? HeaderTitleReusableView else {
            fatalError("Unable to dequeue MyHeaderView")
        }
        headerView.headerTitleLbl.text = "My Albums"
        return headerView
    }

}
extension GallaryViewController : UICollectionViewDelegateFlowLayout{
    
    //MARK:- For cell spacing

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
