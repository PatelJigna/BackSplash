//
//  Scope.swift
//  UnsplashSwift
//
//  Created by Joan Disho on 26.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

public enum Scope {
    
    case pub
    case readUser
    case writeUser
    case readPhotos
    case writePhotos
    case writeLikes
    case writeFollowers
    case readCollections
    case writeCollections
    
    var string: String {
        switch self {
        case .pub:
            return "public"
        case .readUser:
            return "read_user"
        case .writeUser:
            return "write_user" 
        case .readPhotos:
            return "read_photos"
        case .writePhotos:
            return "read_photos"
        case .writeLikes:
            return "write_likes"
        case .writeFollowers:
            return "write_followers"
        case .readCollections:
            return "read_collections"
        case .writeCollections:
            return "write_collections"
        }
    }
}
