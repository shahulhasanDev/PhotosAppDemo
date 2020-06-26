//
//  Extensions.swift
//  Copyright © 2020 Shahul. All rights reserved.
//

import UIKit

//MARK: VIEW CONTROLLER EXTENSIONS
extension UIViewController {
    func showAlert(message:String) -> Void {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: STRING EXENSTION
extension String {
    func urlEncodedString() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}


