//
//  WelcomeVC.swift
//  BackSplash
//
//  Created by Jigna Patel on 27.06.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    let imageViewBackground: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "Welcome-screen-bg")
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover & download high quality wallpapers "
        label.numberOfLines = 2
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Powered by Unsplash"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let swipeUpView: UIView = {
        let view = UIView()
        view.layer.cornerRadius =  75
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        return view
    }()
    
    
    let upArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "swipeUpArrow")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let swipeUplabel: UILabel = {
        let label = UILabel()
        label.text = "Swipe Up"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        setInitialProperty()
       
    }
    
    
    func setInitialProperty() {
        
        self.view.addSubview(imageViewBackground)
        
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: imageViewBackground)
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: imageViewBackground)
        
        self.view.addSubview(centerLabel)
        self.view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: centerLabel)
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: centerLabel)
        
        self.view.addSubview(bottomLabel)
        self.view.addConstraintsWithFormat(format: "H:|-5-[v0]", views: bottomLabel)
        self.view.addConstraintsWithFormat(format: "V:[v0]-5-|", views: bottomLabel)

    
        self.view.addSubview(swipeUpView)
        self.view.addConstraintsWithFormat(format: "H:[v0(150)]-30-|", views: swipeUpView)
        self.view.addConstraintsWithFormat(format: "V:[v0(150)]-30-|", views: swipeUpView)

        
        swipeUpView.addSubview(upArrowImageView)
        swipeUpView.addSubview(swipeUplabel)
        
        upArrowImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        upArrowImageView.centerXAnchor.constraint(equalTo: swipeUpView.centerXAnchor).isActive = true
        
        swipeUplabel.centerXAnchor.constraint(equalTo: swipeUpView.centerXAnchor).isActive = true
        
        swipeUpView.addConstraintsWithFormat(format: "V:|-20-[v0(60)]-5-[v1]", views: upArrowImageView,swipeUplabel)
        

        let objSwipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpHandler(recognizer:)))
        objSwipeUp.direction = .up
        swipeUpView.addGestureRecognizer(objSwipeUp)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()

        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {

        return UIStatusBarStyle.lightContent
    }

    
   @objc func swipeUpHandler(recognizer:UISwipeGestureRecognizer)  {
    
        goToHomeVC()
    
    }
    
    
    func goToHomeVC() {
        
        let homeVC = HomeVC()
        self.navigationController?.pushViewController(homeVC, animated: false)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
