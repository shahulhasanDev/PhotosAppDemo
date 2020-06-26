//
//  UserDefaultManager.swift
//  AirtelTask
//
//  Created by Shahul on 21/06/20.
//  Copyright © 2020 Shahul. All rights reserved.
//

import Foundation


//----------------------------------------------------------------------------------------
//----------------------User Default Manager-------------------------------------------
//----------------------------------------------------------------------------------------

final class UserDefaultManager {
    class func saveValue(value:String) {
        UserDefaults.standard.set(value, forKey: UserDefaultKeys.suggestionKey)
        UserDefaults.standard.synchronize()
    }
    
    class func getValue() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.suggestionKey) ?? ""
    }
}

