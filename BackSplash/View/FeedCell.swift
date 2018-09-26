//
//  LatestCell.swift
//  BackSplash
//
//  Created by Jigna Patel on 18.09.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit


class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
   weak var delegate: DetailVCDelegate?
    
    let latestCellId = "latestCellId"
    
    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    var arrPhotos = [Photo]()
    
    override func setUpViews() {
        addSubview(collectionview)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionview)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionview)
        
        collectionview.register(LatestCell.self, forCellWithReuseIdentifier: latestCellId)
        
        fetchPhotos()
    }
    
    
    
    func fetchPhotos()  {
        ApiService.sharedInstance.getPhotosListingFromUnsplash(getPage: 1, getPerPage: 10, strOrder: .latest) { (isSuccess, arrResponse) in
           
            if isSuccess {
                self.arrPhotos = arrResponse!
                self.collectionview.reloadData()
            }
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: latestCellId, for: indexPath) as! LatestCell
        cell.photo = arrPhotos[indexPath.row]
        //cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 43 + 6)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
       delegate?.goToDetailVC(photo: arrPhotos[indexPath.row])
    }
    
}
       
