//
//  CollectionImageVC.swift
//  NewAppProject
//
//  Created by NT 2 on 13/04/23.
//

import UIKit


class CollectionImageVC: UIViewController {
    @IBOutlet var manu: UIView!
    @IBOutlet var titleLbl: UILabel!
    
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var previousBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!

    @IBOutlet var imageCountlbl: UILabel!
    @IBOutlet var collectionview: UICollectionView!
    
    var imageName = ""
    var headerTitle = ""
    var gallaryImageArr : [String] = []
    
    var totalImage = 0
    var currentIndex = 0
    
//    var gallaryImages = ["Emily","William","Sophia","Liam","Ethan"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manu.alpha = 0
        titleLbl.text = headerTitle
        imageCountlbl.text = "\(currentIndex+1)" + "/" + "\(gallaryImageArr.count)"
        totalImage = gallaryImageArr.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionview.reloadData()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.manu.alpha = 0
    }
   

    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func showManu(_ sender: UIButton) {
        manu.alpha = 1

    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        if currentIndex < totalImage - 1 {
            
            currentIndex += 1
            
                
            let visibleItems = collectionview.indexPathsForVisibleItems
            let currentItem = visibleItems[0]
            let nextItem = IndexPath(item: currentItem.item + 1, section: currentItem.section)
        
            collectionview.scrollToItem(at: nextItem, at: .left, animated: true)
            collectionview.reloadData()
        }
       
    }

    @IBAction func previousButtonTapped(_ sender: UIButton) {

        if currentIndex > 0 {
            
            currentIndex -= 1
            let visibleItems = collectionview.indexPathsForVisibleItems
            let currentItem = visibleItems[0]
            let previousItem = IndexPath(item: currentItem.item - 1, section: currentItem.section)

            collectionview.scrollToItem(at: previousItem, at: .right, animated: true)
            collectionview.reloadData()
        }
        
    }

    
}

extension CollectionImageVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallaryImageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mycell = collectionview.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! ImageCollectionViewCell
        mycell.images.image = UIImage(named: gallaryImageArr[indexPath.row] )

        imageCountlbl.text = "\(currentIndex+1)" + "/" + "\(gallaryImageArr.count)"
        nextBtn.isEnabled = currentIndex < totalImage - 1
        previousBtn.isEnabled = currentIndex > 0
        
        return mycell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionview.contentOffset, size: collectionview.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionview.indexPathForItem(at: visiblePoint) else { return }
        currentIndex = indexPath.row
        imageCountlbl.text = "\(currentIndex+1)" + "/" + "\(gallaryImageArr.count)"
        nextBtn.isEnabled = currentIndex < totalImage - 1
        previousBtn.isEnabled = currentIndex > 0

    }
    
}

extension CollectionImageVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionview.frame.size
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
