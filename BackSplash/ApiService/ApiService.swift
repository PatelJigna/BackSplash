//
//  ApiService.swift
//  BackSplash
//
//  Created by Jigna Patel on 18.09.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit
import AlertBar
import UnsplashSwift

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    //MARK: - Webservice Call
    
    typealias blockGetPhotos = (_ isSuccess:Bool, [Photo]?) -> Void
    
    func getPhotosListingFromUnsplash(getPage:Int,getPerPage:Int, strOrder: OrderBy, completionHandler:@escaping blockGetPhotos) {
        
    
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
            completionHandler(false,nil)
            
            
            
            return
        }
        
        objUnsplash.request(fromTarget: .photos(page: getPage, perPage: getPerPage, orderBy: strOrder)).responseJSON { (response) in
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if response.data != nil {
                    let photos = try decoder.decode([Photo].self, from: response.data!)
                     print(photos)
                    
                    DispatchQueue.main.async {
                        
                        completionHandler(true, photos)
                    }
                    
                }
                
            }
            catch let jsonError {
                print(jsonError)
                completionHandler(false,nil)
            }
            
        }
        
    }
    
}
