//
//  GallaryViewModel.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/2/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import RxSwift
import RxCocoa

class GallaryViewModel {

    // input
    var photosRX  : BehaviorRelay<[Photo]> = BehaviorRelay(value: [])

    // output

    // internal

    init() {
        ServerManager().getPhotos { photosArray in
           // print(photos?.count)
            guard let photos = photosArray else{
                return
            }
            self.photosRX.accept(photos)
        }
        setupRx()
    }
}

// MARK: Setup
private extension GallaryViewModel {

    func setupRx() {

    }
}
