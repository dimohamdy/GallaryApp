//
//  Constant.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/3/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import Foundation

enum API : String {
    case upload = "/user/fileUpload"
    case files = "/user/files"
//    case image(String) =
    
    var url:String {
        return API.domain + self.rawValue
    }

    static let domain:String = "http://192.168.1.4:8080"

}
