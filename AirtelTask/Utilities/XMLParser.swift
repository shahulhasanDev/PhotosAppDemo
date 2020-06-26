//
//  Parser.swift
//  Copyright © 2020 Shahul. All rights reserved.
//

import Foundation

typealias ParseCompletion = ([ImageModel]?, _ error:String?) -> Void

class AXMLParser: NSObject, ParserProtocol, XMLParserDelegate  {
    private var images:[ImageModel] = [ImageModel]()
    private var completion:ParseCompletion?
    
    func startParsing(data:Data, completion:@escaping ParseCompletion) -> Void {
        self.completion = completion
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.completion?(images, nil)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // Parse element here
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let _ = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func parser(_ parser: XMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        self.completion?(images, parseError.localizedDescription)
    }
}
