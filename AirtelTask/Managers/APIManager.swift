//
//  APIManager.swift
//
//  Copyright © 2020 Shahul. All rights reserved.
//

import UIKit


class APIManager: NSObject {
    
    class func fetchData(api:API, parsingType:AParsingType, text:String, completion:@escaping ParseCompletion) -> Void {
        guard let url = URL(string: api.url()) else {
            return
        }
        // Need to change this code to support all other types like POST, PUT, PATCH, DELETE
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                guard let data = data else {
                if let error = error {
                    completion(nil, error.localizedDescription)
                }
                return
            }
            // Below code select parser by parsing type
            if parsingType == .json {
                AParser.parseResponse(data: data, completion: completion, parser: AJSONParser())
            } else {
                AParser.parseResponse(data: data, completion: completion, parser: AXMLParser())
            }
        })
        task.resume()
    }
}

// Enum to handle all APIs. Add more cases to add more API
enum API {
    case pixelBay( text:String, pageNo:Int, domain:ADomain, apiName: APIName)
    func url() -> String {
        switch self {
        case .pixelBay(let text, let pageNo, let domain, let apiKey):
                let encodedString:String = text.urlEncodedString()
                let urlString:String = domain.rawValue + apiKey.val() + "&per_page=10&q=\(encodedString)" + "&page=\(pageNo)"
            return urlString
        
        }
    }
}

enum ADomain:String {
    case pixelBay = "https://pixabay.com/"
    // Add More Cases to add more domain
}

enum APIName {
    case pixelBay
    func val() -> String {
        switch self {
        case .pixelBay:
             return "api/?key=\(Constants.APIKEY)&image_type=\(ImageType.photo)"
        }
    }
    // Add More Cases to more api Keys
}


