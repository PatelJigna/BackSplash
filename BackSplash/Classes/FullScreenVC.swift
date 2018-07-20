//
//  BSFullScreenVC.swift
//  BackSplash
//
//  Created by Jigna Patel on 21.06.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlertBar

class FullScreenVC: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var viewSelectedImg: UIView!
    
    @IBOutlet weak var imgviewFullScreen: UIImageView!
    
    @IBOutlet weak var imgviewAuthor: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var dictSelectedImgInfo:[String:JSON]?
    
    var imgToDownload:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInitialValues()
    
    }
    
    func setInitialValues() {
        SharedClass.sharedInstance.setRoundedCorner(view: imgviewAuthor, cornerRadius: imgviewAuthor.frame.width/2, clipsToBounds: true, borderWidth: 1.0, borderColor: UIColor.white.cgColor, isUserInteractionEnabled: true)
        
        lblName.text = dictSelectedImgInfo!["user"]!["name"].string
        imgviewFullScreen.sd_setImage(with: URL(string: dictSelectedImgInfo!["urls"]!["regular"].string!), completed: nil)
        imgviewAuthor.sd_setImage(with: URL(string: dictSelectedImgInfo!["user"]!["profile_image"]["medium"].string!), completed: nil)
       
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    

    //MARK: - Scrollview Delegate Method
   
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgviewFullScreen
    }
    
    //MARK: - Button Actions
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnImgDownloadAction(_ sender: Any) {
        
        
        guard isNetworkAvailable() else {
            
            let options = AlertBar.Options(
                shouldConsiderSafeArea: true,
                isStretchable: true,
                textAlignment: .center
            )
            AlertBar.show(type: .custom(.red, .white), message: kNetworkMsg, options: options)
            return
        }
        
        let url = URL(string: dictSelectedImgInfo!["urls"]!["regular"].string!)
        if let data = try? Data(contentsOf: url!){
            if let image = UIImage(data: data){
                self.imgToDownload = image
            }
        }
        
        if self.imgToDownload != nil{
            
            if let data = UIImagePNGRepresentation(self.imgToDownload!) {
                let filename = getDocumentsDirectory().appendingPathComponent(lblName.text!)
                try? data.write(to: filename)
              
                let options = AlertBar.Options(
                    shouldConsiderSafeArea: true,
                    isStretchable: true,
                    textAlignment: .center
                )
                AlertBar.show(type: .custom(.black, .white), message: kImgDownloaded, options: options)
            }
           
        }
        else{
           //Something went wrong
            let options = AlertBar.Options(
                shouldConsiderSafeArea: true,
                isStretchable: true,
                textAlignment: .center
            )
            AlertBar.show(type: .custom(.red, .white), message: kSomethingWrong, options: options)
        }
        
    }
    
    //MARK: - Other Methods
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        return paths[0]
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
