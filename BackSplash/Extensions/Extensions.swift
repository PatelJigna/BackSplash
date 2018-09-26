//
//  Extensions.swift
//  BackSplash
//
//  Created by Jigna Patel on 16.09.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        //["v0":thumbnailImageView, "v1":seperatorView]
        
        var viewDictionary = [String: UIView]()
        
        for (index,view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let key = "v\(index)"
            viewDictionary[key] = view
            
        }
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}
/*
extension UIImageView {
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
*/
