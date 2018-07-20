//
//  BSHomeTblCell.swift
//  BackSplash
//
//  Created by Jigna Patel on 27.06.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit

class HomeTblCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    
    @IBOutlet weak var imgviewPhoto: UIImageView!
    
    @IBOutlet weak var imgviewAuthorPic: UIImageView!
    
    @IBOutlet weak var lblAuthorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setInitialView()
        
    }
    
    
    func setInitialView() {
        SharedClass.sharedInstance.setShadow(view: viewBg, shadowOffset: CGSize.zero, shadowColor: UIColor.black.cgColor, shadowOpacity: 1.0, backgroundColor: UIColor.white, cornerRadius: 5.0, masksToBounds: false)
        
        SharedClass.sharedInstance.setRoundedCorner(view:  imgviewAuthorPic, cornerRadius:  imgviewAuthorPic.frame.width/2, clipsToBounds: true, borderWidth: 1.0, borderColor: UIColor.white.cgColor, isUserInteractionEnabled: true)

    }
    
  


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
