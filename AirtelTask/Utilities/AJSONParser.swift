//
//  AJSONParser.swift
//  AirtelTask
//
//  Created by Shahul on 19/06/20.
//  Copyright © 2020 Shahul. All rights reserved.
//

import Foundation

class AJSONParser: NSObject, ParserProtocol {
    
    func startParsing(data:Data, completion:@escaping ParseCompletion) -> Void {
        do {
            if let dicts = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
                var arrModels:[ImageModel] = [ImageModel]()
                if let hitsDict = dicts["hits"] as? [[String:Any]] {
                    for d in hitsDict {
                        let model = ImageModel(dict: d)
                        arrModels.append(model)
                    }
                }
                completion(arrModels, nil)
            } else {
                completion(nil, nil)
            }
        } catch  let errorT {
            completion(nil, errorT.localizedDescription)
        }
    }
}
