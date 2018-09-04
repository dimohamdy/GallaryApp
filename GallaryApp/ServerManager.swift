//
//  ServerManager.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/3/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import Alamofire

class ServerManager {

    func getPhotos(completion:@escaping ([Photo]?) -> Void){
        Alamofire.request(API.files.url)
            .responseJSON { response in
                //debugPrint(response)
                
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let photos = try decoder.decode([Photo].self, from: data)
                    completion(photos)
                    //print(photos)
                    
                } catch let err {
                    completion(nil)
                    print("Err", err)
                }
                
        }
    }
}
