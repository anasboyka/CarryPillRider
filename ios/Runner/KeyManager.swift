//
//  KeyManager.swift
//  Runner
//
//  Created by Anas Boyka on 16/12/2022.
//

import Foundation
struct KeyManager {
   private let keyFilePath = Bundle.main.path(forResource: "APIKey",      ofType: "plist")
   func getKeys() -> NSDictionary? {
     guard let keyFilePath = keyFilePath else {
       return nil
     }
     return NSDictionary(contentsOfFile: keyFilePath)
   }
   
   func getValue(key: String) -> AnyObject? {
       guard let keys = getKeys() else {
         return nil
       }
     return keys[key]! as AnyObject
   }
}
