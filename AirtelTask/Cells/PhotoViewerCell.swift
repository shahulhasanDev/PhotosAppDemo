//
//  PhotoViewerCell.swift
//  AirtelTask
//
//  Created by Shahul on 22/06/20.
//  Copyright © 2020 Shahul. All rights reserved.
//

import UIKit

class PhotoViewerCell: UICollectionViewCell {
    
    //MARK:OUTLETS & PROPERTIES
    @IBOutlet weak var iv:UIImageView!
    var model:ImageModel?
    
    //MARK: METHODS
    func updateCell() -> Void {
        guard let modelT = model else { return }
        iv.sd_setImage(with: URL(string: modelT.largeImageURL ?? ""), placeholderImage: UIImage(named: ""))
    }

}
