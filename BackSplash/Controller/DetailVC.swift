//
//  BSFullScreenVC.swift
//  BackSplash
//
//  Created by Jigna Patel on 21.06.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit
import AlertBar

class DetailVC: UIViewController {
    
    var selectedPhoto: Photo? {
        didSet{
            lblAuthorName.text = selectedPhoto?.user?.name
            
            if let urlStringThumb = selectedPhoto?.urls?.regular {
                imgViewSelected.sd_setImage(with: URL(string: urlStringThumb), completed: nil)
            }
            
            if let urlStringProfile = selectedPhoto?.user?.profileImage?.medium {
                imgviewAuthor.sd_setImage(with: URL(string: urlStringProfile), completed: nil)
            }
        }
    }
    
    let viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
        
    }()
    
    let imgViewSelected: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    
     let btnBack:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    let imgviewAuthor: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        SharedClass.sharedInstance.setRoundedCorner(view: imgView, cornerRadius: 12, clipsToBounds: true, borderWidth: 1, borderColor: UIColor.white.cgColor, isUserInteractionEnabled: false)
        return imgView
    }()
    
    let lblAuthorName: UILabel = {
        let label = UILabel()
        label.text = "Author Name"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let btnDownload:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "download"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    var imgToDownload:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.modalPresentationCapturesStatusBarAppearance = true
        setUpViews()
       
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func setUpViews() {
        self.view.addSubview(viewBackground)
        
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: viewBackground)
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: viewBackground)
        
        viewBackground.addSubview(imgViewSelected)
        viewBackground.addConstraintsWithFormat(format: "H:|[v0]|", views: imgViewSelected)
        viewBackground.addConstraintsWithFormat(format: "V:|[v0]|", views: imgViewSelected)
        
        viewBackground.addSubview(btnBack)
        viewBackground.addConstraintsWithFormat(format: "H:|-10-[v0(35)]", views: btnBack)
        viewBackground.addConstraintsWithFormat(format: "V:|-20-[v0(25)]", views: btnBack)
        
        viewBackground.addSubview(imgviewAuthor)
        viewBackground.addSubview(lblAuthorName)
        viewBackground.addSubview(btnDownload)
        
        viewBackground.addConstraintsWithFormat(format: "H:|-5-[v0(24)]-[v1]-[v2(24)]-5-|", views: imgviewAuthor,lblAuthorName,btnDownload)
        
        
        viewBackground.addConstraintsWithFormat(format: "V:[v0(24)]-10-|", views: imgviewAuthor)
        lblAuthorName.bottomAnchor.constraint(equalTo: imgviewAuthor.bottomAnchor,constant: -4).isActive = true
        btnDownload.bottomAnchor.constraint(equalTo: imgviewAuthor.bottomAnchor).isActive = true
        
        
        btnBack.addTarget(self, action: #selector(btnBackAction), for: .touchUpInside)
        btnDownload.addTarget(self, action: #selector(btnImageDownloadAction), for: .touchUpInside)
        
    }

    //MARK: - Button Actions
    
    @objc func btnBackAction() {
         self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnImageDownloadAction()  {
        
        guard isNetworkAvailable() else {
            
            let options = AlertBar.Options(
                shouldConsiderSafeArea: true,
                isStretchable: true,
                textAlignment: .center
            )
            AlertBar.show(type: .custom(.red, .white), message: kNetworkMsg, options: options)
            return
        }
        
        let url = URL(string: (selectedPhoto?.urls?.regular)!)
        if let data = try? Data(contentsOf: url!){
            if let image = UIImage(data: data){
                self.imgToDownload = image
            }
        }
        
        if self.imgToDownload != nil{
            
            if let data = UIImagePNGRepresentation(self.imgToDownload!) {
                let filename = getDocumentsDirectory().appendingPathComponent(lblAuthorName.text!)
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
