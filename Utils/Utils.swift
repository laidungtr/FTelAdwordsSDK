//
//  Utils.swift
//  Karaoke_Plus_Remote
//
//  Created by ttiamap on 5/9/17.
//  Copyright © 2017 ttiamap. All rights reserved.
//

import UIKit

class Utils {
    
    class func getDeviceId() -> String{
        if let deviceID = UIDevice.current.identifierForVendor{
           return String(describing: deviceID)
        }
        return ""
    }
    
    class func getDeviceName() -> String{
        return UIDevice.current.name
    }
}
