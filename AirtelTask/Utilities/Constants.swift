//
//  Constants.swift

//
//  Copyright © 2020 Shahul. All rights reserved.
//

import UIKit

struct Constants {
    static var APIKEY:String = "17108729-eeb8a7f04e13eb6c6a0da20ce"
    static var pixelbayAPI:String = "https://pixabay.com/"
    static var ImageCell:String = "ImageCell"
    static var SuggestionCell:String = "SearchCell"
    static var ImagesPerPage:Int = 10
    static var SuggestionStorageSize:Int = 10
    static var SuggestionQueuePlaceholder:String = "$"
}

struct UserDefaultKeys {
    static var suggestionKey:String = "SearchSuggestionKeys"
}

struct Messgaes {
    static var NoResultsFound:String = "No Results Found!"
    static var SomethingWentWrong:String = "Something went wrong!"
    static var InternetNotAvailable:String = "Internt not available!"
}

//MARK: Image types in API Query Param
enum ImageType:String {
    case photo = "photo"
}
