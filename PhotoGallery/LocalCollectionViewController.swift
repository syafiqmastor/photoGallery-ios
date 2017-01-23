 //
//  LocalCollectionViewController.swift
//  PhotoGallery
//
//  Created by Syafiq Mastor on 1/17/17.
//  Copyright © 2017 Syafiq Mastor. All rights reserved.
//

import UIKit
import Photos
import Alamofire

private let reuseIdentifier = "ImageCell"

class LocalCollectionViewController: UICollectionViewController {
    
    var photosAsset: PHFetchResult<PHAsset>!
    var assetThumbnailSize: CGSize!
    var selections = [PHAsset]()
    var url : URL = URL(string: "lala")!
    
    var barButtonItem : UIBarButtonItem {
       return UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(self.handleBarButtonItem(sender:)))
    }
    
    func handleBarButtonItem(sender : Any) {
        
        let image = UIImage.init(named: "myImage")
        let imgData = UIImageJPEGRepresentation(image!, 0.2)!
        
        let parameters = ["name": "myImage"] 
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },
                         to:"/mampp/htdocs/photoGallery/store_image.php")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print("response: \(response.result.value)")
                }
                
            case .failure(let encodingError):
                print(encodingError)  
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add bar button item
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        
        // register cell nib
        collectionView?.register(UINib(nibName: "ImageCell", bundle: nil),
                                     forCellWithReuseIdentifier: reuseIdentifier)
        
        
        //load all photos in photos
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        photosAsset = PHAsset.fetchAssets(with: allPhotosOptions)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Determine the size of the thumbnails
        let scale = UIScreen.main.scale
        let cellSize = (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        assetThumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosAsset.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = photosAsset.object(at: indexPath.item)
        
        // Dequeue a GridViewCell.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath) as? ImageCell
            else { fatalError("unexpected cell in collection view") }
        
        
        //checkmark configuration
        cell.checkMark.checked = false
        cell.checkMark.checkMarkStyle = CheckMarkStyle.grayedOut
        
        
        // insert image into collection view cell
        PHImageManager.default().requestImage(for: asset, targetSize: self.assetThumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: {(result, info)in
            if let image = result {
                cell.setThumbnailImage(thumbNailImage: image)
            }
        })
        
        
        
        return cell

    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       
        //select photo
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCell else { return false }
        let asset = photosAsset.object(at: indexPath.item)
        
        if let index = selections.index(of: asset) {
            cell.checkMark.setChecked(checked: false)
            selections.remove(at: index)
        } else {
            selections.append(asset)
            cell.checkMark.setChecked(checked: true)
        }
        return true
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selections :\(selections.count)")
    }

}
