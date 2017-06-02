//
//  DictionaryExtension.swift
//  Karaoke_Plus_Remote
//
//  Created by ttiamap on 5/12/17.
//  Copyright © 2017 ttiamap. All rights reserved.
//

import Foundation

extension Dictionary{
    
    func toStringJson() -> String{
        do{
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            return String.init(data: jsonData, encoding: .utf8) ?? ""
        }catch let error{
            print("convert dictionary to json string error: \(error)")
        }
        
        return ""
    }
}
