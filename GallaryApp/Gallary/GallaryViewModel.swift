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
    var photosRX  : BehaviorRelay<[Photo]> = BehaviorRelay(value: [])

    // output

    // internal

    override init() {
        super.init()
        setupRx()
        getImages()
    }
    func getImages(){
        ServerManager().getPhotos { photosArray in
            // print(photos?.count)
            guard let photos = photosArray else{
                return
            }
            self.photosRX.accept(photos)
        }
    }
    
    func upload(image:UIImage) {
        self.loading.accept(true)
        ServerManager().upload(image: image) { [weak self] photoObj in
            self?.loading.accept(false)
            guard let photo = photoObj else{
                return
            }
            var photos = self!.photosRX.value 
            photos.append(photo)
            self?.photosRX.accept(photos)
        }
    }
}

// MARK: Setup
private extension GallaryViewModel {

    func setupRx() {

    }
    
    

}
