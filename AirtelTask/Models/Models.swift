//
//  Model.swift
//
//  Copyright © 2020 Shahul. All rights reserved.
//

import UIKit

struct ImageModel {
    var previewURL: String?
    var largeImageURL: String?
    init(dict:[String:Any]) {
        if let prevUrl = dict["previewURL"] as? String {
            self.previewURL = prevUrl
        }
        if let largeUrl = dict["largeImageURL"] as? String {
            self.largeImageURL = largeUrl
        }
    }
}

struct SearchSuggestionModel {
    var text:String
}
