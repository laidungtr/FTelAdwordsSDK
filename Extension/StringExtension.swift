//
//  StringExtension.swift
//  Karaoke_Plus_Remote
//
//  Created by ttiamap on 5/9/17.
//  Copyright © 2017 ttiamap. All rights reserved.
//

import Foundation


extension String{
    
    var length: Int {
        return characters.count
    }
    
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    func base64EncodedData() -> Data? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedData()
        }
        return nil
    }
    
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func toBool() -> Bool{
        let string = self.uppercased()
        let number = string.toIntPositive()
        switch string {
        case "TRUE","YES","1":
            //
            return true
            
        case "FALSE","NO","0":
            //
            return false
            
        default:
            //
            return number > 0 ? true : false
            
        }
    }
    
    
    func toDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) ?? ""
    }
    
    ///Return plantCharacter ex Ắ => A
    func toPlantext() -> String {
        return self.folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    func toPlanTextLatinBasic() -> String{
        var newString = self
        newString = newString.toPlantext().replacingOccurrences(of: "đ", with: "d")
        newString = newString.toPlantext().replacingOccurrences(of: "Đ", with: "D")
        
        return newString
    }
    
    ///Return to NSDate, use .formatVN
    func toDate() -> NSDate {
        let date = NSDate(timeIntervalSince1970: self.toDouble(defaultNumber: 0));
        return date
    }
    
    ///Return to Int, if not Number, return -1
    func toIntPositive() -> Int {
        return self.toInt(defaultNumber: -1);
    }
    
    ///Return to Int, if not Number, return defaultNumber
    func toInt(defaultNumber: Int) -> Int {
        let num = Int(self);
        if num != nil {
            return num!;
        } else {
            return defaultNumber;
        }
    }
    
    ///Return to Double, if not Number, return defaultNumber
    func toDouble(defaultNumber: Double) -> Double {
        
        if let num = Double(self){
            return num;
        }
        return defaultNumber
    }
    
    ///Return Image Url  with  Width
//    func toCatPathSendoURL() -> String {
//        let string  = self;
//        return Config.sendoDomain + "/" + string
//    }
    
//    func withDomainCDN() -> String {
//        var string = "/" + self
//        string = string.stringByReplacingOccurrencesOfString("//", withString: "/")
//        string = Config.cdnDomain + string
//        return string
//    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func roundNumber(optionFormat:Double) -> String {
        var string = self
        var double  = string.toDouble(defaultNumber: 0)
        double = Double(round(optionFormat * double) / optionFormat)
        if(double > 0) {
            
            string = (double == 0) ? "0" : String(double)
        } else {
            string = "0"
        }
        return string
    }
    
    func trimWhiteSpaceAndNewLine() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}
