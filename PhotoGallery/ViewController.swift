//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Syafiq Mastor on 1/17/17.
//  Copyright © 2017 Syafiq Mastor. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var photoAssets : [PHAsset] = []
    var assetThumbnailSize: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ImageCell", bundle: nil),
                                 forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Determine the size of the thumbnails
        let size = UIScreen.main.bounds.size
//        let cellSize = (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        assetThumbnailSize = CGSize(width: size.width / 3, height: size.width/3)
    }

    @IBAction func handleAddBarButton(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LocalCollectionViewController") as! LocalCollectionViewController
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    

    
    //    func convertAssetToImage(asset : PHAsset) {
    //        PHImageManager.default().requestImage(for: asset, targetSize: self.assetThumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: {(result, info)in
    //            if let image = result {
    //
    //            }
    //        })
    //    }

}

extension ViewController : GalleryDelegate {
    func sendAssetsToParent(assets: [PHAsset]) {
        photoAssets = assets
        self.collectionView.reloadData()
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = photoAssets[indexPath.item]
        
        // Dequeue a GridViewCell.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath) as? ImageCell
            else { fatalError("unexpected cell in collection view") }
        
        //checkmark configuration
        cell.checkMark.isHidden = true
        
        // insert image into collection view cell
        PHImageManager.default().requestImage(for: asset, targetSize: self.assetThumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: {(result, info)in
            if let image = result {
                cell.setThumbnailImage(thumbNailImage: image)
            }
        })
        
        
        
        return cell
        
    }
    
    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

}

