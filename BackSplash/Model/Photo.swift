//
//  File.swift
//  BackSplash
//
//  Created by Jigna Patel on 18.09.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import UIKit

class Photo: NSObject,Decodable {
    
    var user: User?
    var urls: Url?
    
}

class User: NSObject,Decodable {
    var name: String?
    var profileImage: ProfileImage?
}


class ProfileImage: NSObject,Decodable {
    var medium: String?
}

class Url: NSObject,Decodable {
    var regular: String?
}
