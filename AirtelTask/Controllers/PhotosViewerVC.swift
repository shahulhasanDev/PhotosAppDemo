//
//  PhotosViewerVC.swift
//  AirtelTask
//
//  Created by Shahul on 22/06/20.
//  Copyright © 2020 Shahul. All rights reserved.
//

import UIKit

class PhotosViewerVC: UIViewController {
    
    private lazy var arrData:[ImageModel] = [ImageModel]()
    private var currentIndex:Int?
    @IBOutlet weak var collView:UICollectionView!
    
    class func getInstance(arrData:[ImageModel], currentIndex:Int) -> PhotosViewerVC? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let photosVC = storyboard.instantiateViewController(identifier: String(describing: PhotosViewerVC.self)) as? PhotosViewerVC
        photosVC?.arrData = arrData
        photosVC?.currentIndex = currentIndex
        return photosVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction(_:)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collView.reloadData()
        scrollToCurrentIndex()
    }
    
    private func scrollToCurrentIndex() {
        if let index = currentIndex {
            self.collView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    @objc func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: COLLECTIONVIEW DELEGATES & DATASOURCE
extension PhotosViewerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoViewerCell.self), for: indexPath) as? PhotoViewerCell {
            cell.model = arrData[indexPath.item]
            cell.updateCell()
            return cell
        }
        return UICollectionViewCell()
    }
}

extension PhotosViewerVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widhth = self.collView.bounds.size.width
        let height = self.collView.bounds.size.height
        return CGSize(width: widhth, height: floor(height))
    }
}


