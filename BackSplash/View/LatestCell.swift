//
//  LatestCell.swift
//  BackSplash
//
//  Created by Jigna Patel on 18.09.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit
import SDWebImage

class LatestCell: BaseCell {
    
    var photo: Photo? {

        didSet {
            lblAuthorName.text = photo?.user?.name
            
            if let urlStringThumb = photo?.urls?.regular {
                imgViewPhoto.sd_setImage(with: URL(string: urlStringThumb), completed: nil)
            }
            
            if let urlStringProfile = photo?.user?.profileImage?.medium {
                imgViewProfilePic.sd_setImage(with: URL(string: urlStringProfile), completed: nil)
            }
            
        }
    }
    
    let viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear

        view.layer.shadowRadius = 12.0
        SharedClass.sharedInstance.setShadow(view: view, shadowOffset: CGSize.zero, shadowColor: UIColor.gray.cgColor, shadowOpacity: 0.3, backgroundColor: UIColor.white, cornerRadius: 16.0, masksToBounds: false)
        return view
    }()
    
    let imgViewPhoto: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
         SharedClass.sharedInstance.setRoundedCorner(view: imageview, cornerRadius: 16, clipsToBounds: true, borderWidth: 0, borderColor: UIColor.clear.cgColor, isUserInteractionEnabled: false)
        return imageview
    }()
    
    let imgViewProfilePic: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
         SharedClass.sharedInstance.setRoundedCorner(view: imageview, cornerRadius: 12, clipsToBounds: true, borderWidth: 1, borderColor: UIColor.white.cgColor, isUserInteractionEnabled: false)
        return imageview
    }()
    
    let lblAuthorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    
    let viewSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    override func setUpViews() {
        addSubview(viewBackground)
        viewBackground.addSubview(imgViewPhoto)
        viewBackground.addSubview(imgViewProfilePic)
        viewBackground.addSubview(lblAuthorName)
        //addSubview(viewSeperator)
    
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: viewBackground)
        addConstraintsWithFormat(format: "V:|-16-[v0]|", views: viewBackground)
        
        //Vertical Constraint
    
        viewBackground.addConstraintsWithFormat(format: "V:|[v0]|", views: imgViewPhoto)
        viewBackground.addConstraintsWithFormat(format: "V:[v0(24)]-12-|", views: imgViewProfilePic)
        
        //Horizontal Constraint
        viewBackground.addConstraintsWithFormat(format: "H:|[v0]|", views: imgViewPhoto)
        viewBackground.addConstraintsWithFormat(format: "H:|-16-[v0(24)]-5-|", views: imgViewProfilePic)
        
    
        //Top
        
         viewBackground.addConstraint(NSLayoutConstraint.init(item: lblAuthorName, attribute: .top, relatedBy: .equal, toItem: imgViewProfilePic, attribute: .top, multiplier: 1, constant: 0))
        
        //Left
        
         viewBackground.addConstraint(NSLayoutConstraint.init(item: lblAuthorName, attribute: .left, relatedBy: .equal, toItem: imgViewProfilePic, attribute: .right, multiplier: 1, constant: 8))
        
        //Right
        
         viewBackground.addConstraint(NSLayoutConstraint.init(item: lblAuthorName, attribute: .right, relatedBy:.equal , toItem: imgViewPhoto, attribute: .right, multiplier: 1, constant: 0))
        
        //Height
        
          viewBackground.addConstraint(NSLayoutConstraint.init(item: lblAuthorName, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
    
    }
    

}
