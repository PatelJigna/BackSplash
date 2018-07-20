//
//  WelcomeVC.swift
//  BackSplash
//
//  Created by Jigna Patel on 27.06.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var viewSwipeUp: UIView!
    
    var boolGoToHomeVC:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialProperty()
    }
    
  
    func setInitialProperty() {
        
        viewSwipeUp.layer.cornerRadius =  viewSwipeUp.frame.width/2
        viewSwipeUp.clipsToBounds = true
        viewSwipeUp.isUserInteractionEnabled = true
        
        boolGoToHomeVC = false
        
        let objSwipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpHandler(recognizer:)))
        objSwipeUp.direction = .up
        viewSwipeUp.addGestureRecognizer(objSwipeUp)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        
        guard boolGoToHomeVC == false else {
            return UIStatusBarStyle.default
        }
        return UIStatusBarStyle.lightContent
        
       
    }

    
   @objc func swipeUpHandler(recognizer:UISwipeGestureRecognizer)  {
    
        goToHomeVC(getVC: self)
    
    }
    
    
    func goToHomeVC(getVC:UIViewController) {
        
        let objHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        
        getVC.view.addSubview(objHomeVC.view)
        getVC.addChildViewController(objHomeVC)
        
        objHomeVC.view.frame = CGRect(x: getVC.view.frame.origin.x, y: self.view.frame.height, width: getVC.view.frame.size.width, height: getVC.view.frame.size.height)
        
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
             objHomeVC.view.frame = CGRect(x: getVC.view.frame.origin.x, y: 0, width: getVC.view.frame.size.width, height: getVC.view.frame.size.height)
            
           
            
        }) { (completion) in
            self.boolGoToHomeVC = true
            self.setNeedsStatusBarAppearanceUpdate()
        
        }
        
    }
    

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
