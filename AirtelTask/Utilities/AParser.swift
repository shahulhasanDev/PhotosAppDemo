//
//  AParser.swift
//  AirtelTask
//
//  Created by Shahul on 19/06/20.
//  Copyright © 2020 Shahul. All rights reserved.
//

import Foundation

//MARK: PARSER PROTOCOL
protocol ParserProtocol:NSObject {
    func startParsing(data:Data, completion:@escaping ParseCompletion) -> Void
}

class AParser:  NSObject {
    class func parseResponse(data:Data, completion:@escaping ParseCompletion , parser:ParserProtocol) -> Void {
        parser.startParsing(data: data, completion: completion)
    }
}

enum AParsingType {
    case xml, json
}

