//
//  GallaryBuilder.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/2/18.
//  Copyright (c) 2018 BinaryBoy. All rights reserved.
//

import UIKit

struct GallaryBuilder {

    static func viewController() -> GallaryViewController {
        let viewModel = GallaryViewModel()
        let router = GallaryRouter()
        let viewController = GallaryViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
    
    
    static func navigationController() -> UINavigationController {
    
        let viewModel = GallaryViewModel()
        let router = GallaryRouter()
   
        guard let navigationController = UIStoryboard.instantiateInitialViewController(AppStoryboard.gallary) as? UINavigationController,let viewController = navigationController.viewControllers.first as? GallaryViewController else {
            return UIStoryboard.instantiateInitialViewController(AppStoryboard.gallary) as! UINavigationController
        }
        viewController.viewModel = viewModel
        viewController.router = router
        
        router.viewController = viewController
        
        return navigationController
        
    }
}
