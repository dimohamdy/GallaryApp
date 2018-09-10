//
//  GallaryViewModel.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/2/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import RxSwift
import RxCocoa

class GallaryViewModel : BaseViewModel {

    // input

    // output
    var photosRX  : BehaviorRelay<[Photo]> = BehaviorRelay(value: [])

    // internal

    override init() {
        super.init()
        setupRx()
        getImages()
    }
    
    func getImages(){
        self.loading.accept(true)
        ServerManager.getPhotos { photosArray in
            // print(photos?.count)
            guard let photos = photosArray else{
                return
            }
            self.loading.accept(false)
            self.photosRX.accept(photos)
        }
    }
    
    func upload(image:UIImage) {
        self.loading.accept(true)
        ServerManager.upload(image: image) { [weak self] photoObj in
            guard let photo = photoObj else{
                return
            }
            var photos = self!.photosRX.value 
            photos.append(photo)
            self?.photosRX.accept(photos)
            self?.loading.accept(false)
        }
    }
}

// MARK: Setup
private extension GallaryViewModel {

    func setupRx() {

    }
    
    

}
