//
//  PopularCell.swift
//  BackSplash
//
//  Created by Jigna Patel on 18.09.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit

class PopularCell: FeedCell {
    
    override func fetchPhotos() {
        ApiService.sharedInstance.getPhotosListingFromUnsplash(getPage: 1, getPerPage: 10, strOrder: .popular) { (isSuccess, arrResponse) in
            
            if isSuccess {
                self.arrPhotos = arrResponse!
                self.collectionview.reloadData()
            }
        }
    }
    
}
