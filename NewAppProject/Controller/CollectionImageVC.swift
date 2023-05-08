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
        
        currentIndex = (currentIndex + 1) % gallaryImageArr.count
        self.collectionview.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }

    @IBAction func previousButtonTapped(_ sender: UIButton) {
        
        
        currentIndex = (currentIndex + gallaryImageArr.count - 1) % gallaryImageArr.count
        collectionview.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
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
    
    
    // This is sliding images us
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        currentIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            let contentOffset = scrollView.contentOffset.x
            let contentWidth = scrollView.contentSize.width
            let pageWidth = scrollView.bounds.width
            let currentPage = currentIndex
            let nextPage = contentOffset > CGFloat(currentPage) * pageWidth ? (currentPage + 1) % gallaryImageArr.count : (currentPage - 1 + gallaryImageArr.count) % gallaryImageArr.count
            let nextX = CGFloat(nextPage) * pageWidth
            let distance = abs(contentOffset - nextX)
            let duration = TimeInterval(distance / pageWidth * 0.3)
            currentIndex = nextPage
            UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut], animations: {
                scrollView.contentOffset.x = nextX
            }, completion: nil)
        }
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
