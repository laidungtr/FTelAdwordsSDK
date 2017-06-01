//
//  DataExtension.swift
//  Karaoke_Plus_Remote
//
//  Created by ttiamap on 5/16/17.
//  Copyright © 2017 ttiamap. All rights reserved.
//

import Foundation

extension Data{
    
    func toDictionary() throws -> [String: Any]?{
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
        } catch {
            throw error
        }
    }
}
