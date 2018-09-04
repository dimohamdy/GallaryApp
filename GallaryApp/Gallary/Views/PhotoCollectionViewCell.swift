//
//  PhotoCollectionViewCell.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/3/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell,ReusableCellView {
   
    
    func configureCellWith(photo:Photo) {
        let url = URL(string:API.domain + photo.imagePath!)!
        imageView.kf.setImage(with: url)
    }
    
    @IBOutlet weak var imageView: UIImageView!
}
