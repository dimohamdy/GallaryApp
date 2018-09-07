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
    
    var url:String {
        return API.domain + self.rawValue
    }
    //FIXME:Please change ip address of the server
    static let domain:String = "http://192.168.1.3:8080"

}
