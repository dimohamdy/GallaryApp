//
//  PhotoCollectionViewCell.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/3/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell,ReusableCellView {
   
    
    func configureCellWith(photo:Photo) {
        guard let path = photo.imagePath  else {
            return
        }
        imageView.setImageWith(path)
    }
    
    @IBOutlet weak var imageView: UIImageView!
}
