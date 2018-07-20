//
//  SharedClass.swift
//  BackSplash
//
//  Created by Jigna Patel on 11.07.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit

class SharedClass: NSObject {
    
    static var sharedInstance:SharedClass = SharedClass()

    func setShadow(view:UIView, shadowOffset:CGSize, shadowColor:CGColor, shadowOpacity:Float, backgroundColor:UIColor, cornerRadius:CGFloat, masksToBounds:Bool) {
        
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowColor = shadowColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.masksToBounds = masksToBounds
    }
    
    
    func setRoundedCorner(view:UIView, cornerRadius:CGFloat, clipsToBounds:Bool, borderWidth:CGFloat, borderColor:CGColor, isUserInteractionEnabled:Bool)  {
        view.layer.cornerRadius =  cornerRadius
        view.clipsToBounds = clipsToBounds
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
        view.isUserInteractionEnabled = isUserInteractionEnabled
    }
    
}
