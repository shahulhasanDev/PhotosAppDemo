//
//  ViewModel.swift
//  Copyright © 2020 Shahul. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    
    private var pageNo:Int = 1
    private var prevText:String?
    private var isHalt:Bool = false
    var didGetResponse:(()->(Void))?
    var didGetError:((String)->(Void))?
    var arrData:[ImageModel] = [ImageModel]()
    
    func fetchData(text:String) {
        updatePageNo(currentText: text)
        APIManager.fetchData(api: .pixelBay(text: text, pageNo: pageNo, domain: .pixelBay, apiName: .pixelBay), parsingType: .json, text: text) { [weak self] (models, error) in
            DispatchQueue.main.async {
                if let errorT = error {
                    self?.didGetError?(errorT)
                } else {
                    let modelsT:[ImageModel] = models ?? [ImageModel]()
                    if !modelsT.isEmpty {
                        SearchManager.shared.saveSuggestion(suggestion: text)
                    }
                    self?.updateHalting(currentModelsCount: modelsT.count)
                    self?.arrData.append(contentsOf: modelsT)
                    self?.didGetResponse?()
                }
            }
        }
        prevText = text
    }
    
    private func updatePageNo(currentText:String) -> Void {
        if let previousText = prevText, previousText == currentText {
            pageNo += 1
        } else {
            removeAllContents()
            setInitialValues()
        }
    }
    
    private func updateHalting(currentModelsCount:Int) -> Void {
        if currentModelsCount < Constants.ImagesPerPage {
            isHalt = true
        }
    }

    func removeAllContents() {
        arrData.removeAll()
    }
    
    func isHalted() -> Bool {
        return isHalt
    }
    
    func setInitialValues() -> Void {
        isHalt = false
        pageNo = 1
        prevText = nil
    }
}



