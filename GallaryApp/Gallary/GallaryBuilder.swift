//
//  GallaryBuilder.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/2/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import UIKit

struct GallaryBuilder {

    static func viewController() -> UIViewController {
        let viewModel = GallaryViewModel()
        let router = GallaryRouter()
        let viewController = GallaryViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
}
