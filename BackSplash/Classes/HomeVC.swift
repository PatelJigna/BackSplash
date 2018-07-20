//
//  BSHomeVC.swift
//  BackSplash
//
//  Created by Jigna Patel on 20.06.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit
import UnsplashSwift
import SwiftyJSON
import SDWebImage
import AlertBar

class HomeVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var tblViewImageListing: UITableView!
    
    @IBOutlet weak var btnLatest: UIButton!
    
    @IBOutlet weak var btnPopular: UIButton!
    
    var arrLatestPhotoResponse = [JSON]()
    var arrPopularPhotoResponse = [JSON]()
    
    var intLatestPage:Int = 1
    var intLatestPerPage:Int = 10
    
    var intPopularPage:Int = 1
    var intPopularPerPage:Int = 10
    
     var isboolLatestSelected:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        super.viewDidLoad()

        setIntialValues()
        
    }

    func setIntialValues() {
       
        
        isboolLatestSelected = true
        
        btnLatest.addTarget(self, action: #selector(btnSelectedOrder(sender:)), for: .touchUpInside)
        btnLatest.tag = 100
        btnPopular.addTarget(self, action: #selector(btnSelectedOrder(sender:)), for: .touchUpInside)
        btnPopular.tag = 200
        
        if isboolLatestSelected!{
            getPhotosListingFromUnsplash(getPage: intLatestPage, getPerPage: intLatestPerPage)
            
        }
        else{
            getPhotosListingFromUnsplash(getPage: intPopularPage, getPerPage: intPopularPerPage)
            
        }
        
        tblViewImageListing.separatorColor = UIColor.clear
    }
    
    //MARK: - UItableview Datasource Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isboolLatestSelected! {
            return arrLatestPhotoResponse.count
        }
        else{
            return arrPopularPhotoResponse.count
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTblCell") as! HomeTblCell
        let strPhoto:String?
        let strAuthorPic:String?
        
        if isboolLatestSelected! {
            
             cell.lblAuthorName.text = arrLatestPhotoResponse[indexPath.row]["user"]["name"].string
             strPhoto = arrLatestPhotoResponse[indexPath.row]["urls"]["regular"].string
             strAuthorPic = arrLatestPhotoResponse[indexPath.row]["user"]["profile_image"]["medium"].string
            

        }
        else{
             cell.lblAuthorName.text = arrPopularPhotoResponse[indexPath.row]["user"]["name"].string
             strPhoto = arrPopularPhotoResponse[indexPath.row]["urls"]["regular"].string
             strAuthorPic = arrPopularPhotoResponse[indexPath.row]["user"]["profile_image"]["medium"].string
            
        }
        
       
        cell.imgviewPhoto.sd_setImage(with: URL(string: strPhoto!), completed: nil)
        cell.imgviewAuthorPic.sd_setImage(with: URL(string: strAuthorPic!), completed: nil)
        
        cell.selectionStyle = .none
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let objFullScreen = self.storyboard?.instantiateViewController(withIdentifier: "FullScreenVC") as! FullScreenVC
        
        if isboolLatestSelected!{
             objFullScreen.dictSelectedImgInfo = arrLatestPhotoResponse[indexPath.row].dictionary
        }
        else{
             objFullScreen.dictSelectedImgInfo = arrPopularPhotoResponse[indexPath.row].dictionary
        }
        
       
        self.navigationController?.pushViewController(objFullScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        
        if isboolLatestSelected! {
            
            if indexPath.row == arrLatestPhotoResponse.count - 1 {
                //we are at last cell
                intLatestPage = intLatestPage + 1
                
                getPhotosListingFromUnsplash(getPage: intLatestPage, getPerPage: intLatestPerPage)
            }
            
        }
        else{
            
            if indexPath.row == arrPopularPhotoResponse.count - 1 {
                //we are at last cell
                intPopularPage = intPopularPage + 1
                
                getPhotosListingFromUnsplash(getPage: intPopularPage, getPerPage: intPopularPerPage)
            }
        }
        
       
    }
        
    //MARK: - Button Actions
    
   @objc func btnSelectedOrder(sender:UIButton) {
        
        if sender.tag == 100 {
            isboolLatestSelected = true
            btnLatest.setTitleColor(UIColor.black, for: .normal)
            btnPopular.setTitleColor(UIColor.gray, for: .normal)
            getPhotosListingFromUnsplash(getPage: intLatestPage, getPerPage: intLatestPerPage)
        }
        else{
            isboolLatestSelected = false
            btnLatest.setTitleColor(UIColor.gray, for: .normal)
            btnPopular.setTitleColor(UIColor.black, for: .normal)
            getPhotosListingFromUnsplash(getPage: intPopularPage, getPerPage: intPopularPerPage)
        }
    
    }
    
    
    //MARK: - Webservice Call
    func getPhotosListingFromUnsplash(getPage:Int,getPerPage:Int) {
        
        var strOrder:OrderBy
        if isboolLatestSelected == true {
            strOrder = .latest
        }
        else{
            strOrder = .popular
        }
        
        let objUnsplash = Provider<Unsplash>(clientID: unsplash_Client_ID)
        
        guard isNetworkAvailable() else{
            let options = AlertBar.Options(
                shouldConsiderSafeArea: true,
                isStretchable: true,
                textAlignment: .center
            )
            
            let delay = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: delay){
                
                AlertBar.shared.show(type: .custom(.red, .white), message: kNetworkMsg, duration: 30, options: options, completion: nil)
            }
            
            return
        }
        
        objUnsplash.request(fromTarget: .photos(page: getPage, perPage: getPerPage, orderBy: strOrder)).responseJSON { (response) in
            
            do{
                 let json = try JSON(data: response.data!)
              
                let arr = json.arrayValue
               // self.arrPhotoResponse = json.arrayValue
                
                if self.isboolLatestSelected == true {
                    self.arrLatestPhotoResponse.append(contentsOf: arr)
                    print(self.arrLatestPhotoResponse)
                    print("Latest Arr count :\(self.arrLatestPhotoResponse.count)")
                }
                else{
                    self.arrPopularPhotoResponse.append(contentsOf: arr)
                    print(self.arrPopularPhotoResponse)
                    print("Poplular Arr count :\(self.arrPopularPhotoResponse.count)")
                }
                
               
                self.tblViewImageListing.reloadData()
                
            }
            catch{
                print(error)
            }
        
        }
        
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
