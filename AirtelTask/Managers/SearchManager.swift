//
//  SearchManager.swift
//  AirtelTask
//
//  Created by Shahul on 21/06/20.
//  Copyright © 2020 Shahul. All rights reserved.
//

import Foundation

// Singletone class as this class may be used for search from different controllers
class SearchManager {
    lazy private var suggestions:[String] = [String]()
    static let shared:SearchManager =  SearchManager()
    private init() {
        populateSuggestions()
    }
    
    private func populateSuggestions() {
        suggestions.removeAll()
        let allSuggestionString = UserDefaultManager.getValue()
        if !allSuggestionString.isEmpty {
            let arraySuggs = allSuggestionString.components(separatedBy: Constants.SuggestionQueuePlaceholder)
            suggestions.append(contentsOf: arraySuggs)
        }
    }
    
    func saveSuggestion(suggestion:String) -> Void {
        if suggestions.contains(suggestion) {
            return
        }
        var queue = SuggestionQueue(arrSuggestions: suggestions)
        queue.enQueue(value: suggestion)
        if let suggs = queue.arrSuggestions, !suggs.isEmpty {
            var finalStr:String = ""
            for i in 0..<suggs.count {
                finalStr += suggs[i] + Constants.SuggestionQueuePlaceholder
            }
            finalStr.removeLast()
            UserDefaultManager.saveValue(value: finalStr)
            populateSuggestions()
        }
    }
    
    func getSuggestions() -> [SearchSuggestionModel] {
        var arrSuggsModels:[SearchSuggestionModel] = [SearchSuggestionModel]()
        for sugg in suggestions {
            let model = SearchSuggestionModel(text: sugg)
            arrSuggsModels.append(model)
        }
        return arrSuggsModels
    }
}


