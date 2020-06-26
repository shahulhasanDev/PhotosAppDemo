//
//  ImageCell.swift
//
//  Copyright © 2020 Shahul. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCell: UITableViewCell {
    
    //MARK:OUTLETS & PROPERTIES
    @IBOutlet weak var iv:UIImageView!
    var model:ImageModel?
    
    //MARK: METHODS
    func updateCell() -> Void {
        guard let modelT = model else { return }
        iv.sd_setImage(with: URL(string: modelT.previewURL ?? ""), placeholderImage: UIImage(named: ""))
    }

}
