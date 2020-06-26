//
//  SearchQueue.swift
//  AirtelTask
//
//  Created by Shahul on 23/06/20.
//  Copyright © 2020 Shahul. All rights reserved.
//

import Foundation

//----------------------------------------------------------------------------------------
//----------------------SEARCH SUGGESTION QUEUE-------------------------------------------
//----------------------------------------------------------------------------------------

//MARK: SEARCH SUGGESTION QUEUE
struct SuggestionQueue {
    var arrSuggestions:[String]?
    
    init(arrSuggestions:[String]) {
        self.arrSuggestions = arrSuggestions
    }
        
    mutating func enQueue(value:String) -> Void {
        arrSuggestions?.insert(value, at: 0)
        if let tempArray = arrSuggestions, tempArray.count > Constants.SuggestionStorageSize {
            deQueue()
        }
    }

    private mutating func deQueue() -> Void {
        arrSuggestions?.removeLast()
    }
}



