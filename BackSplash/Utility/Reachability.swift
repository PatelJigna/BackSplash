//
//  Reachability.swift
//  BackSplash
//
//  Created by Jigna Patel on 20.07.18.
//  Copyright © 2018 Jigna Patel. All rights reserved.
//

import Foundation
import UIKit
import Reachability

func isNetworkAvailable() -> Bool {
    
    var isAvailable:Bool?
    
    let hostStatus = Reachability.forInternetConnection().currentReachabilityStatus()
    
    switch hostStatus {
    case .NotReachable:
        isAvailable = false
        
    case .ReachableViaWiFi:
        isAvailable = true
        
    case .ReachableViaWWAN:
        isAvailable = true
        
    }
    
    return isAvailable!
    
}

