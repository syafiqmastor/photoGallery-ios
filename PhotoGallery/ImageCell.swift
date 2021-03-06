//
//  ImageCell.swift
//  PhotoGallery
//
//  Created by Syafiq Mastor on 1/17/17.
//  Copyright © 2017 Syafiq Mastor. All rights reserved.
//

import UIKit

let reuseIdentifier = "ImageCell"

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var checkMark: CheckMark!
    @IBOutlet weak var cellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.checkMark.checked = false
        // Initialization code
    }

    func setThumbnailImage(thumbNailImage: UIImage) {
        self.cellImageView.image = thumbNailImage
    }
}
