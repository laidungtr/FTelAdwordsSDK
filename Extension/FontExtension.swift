//
//  FontExtension.swift
//  Karaoke_Plus_Remote
//
//  Created by ttiamap on 5/10/17.
//  Copyright © 2017 ttiamap. All rights reserved.
//

import Foundation
import UIKit

enum fontNameType: String {
    case roboto_regular = "Roboto-Regular"
    case roboto_Bold = "Roboto-Bold"
}

enum fontSizeType: CGFloat {
    case small = 10.0
    case medium = 12.0
    case big = 14.0
    case large = 16.0
}

extension UIFont{
    
    //MARK: - BOLD
    ///use font BOLD - SMALL (10)
    class func font(_ name: fontNameType, fontsize: fontSizeType) -> UIFont {
        return UIFont(name: name.rawValue, size: fontsize.rawValue) ?? UIFont()
    }
}
