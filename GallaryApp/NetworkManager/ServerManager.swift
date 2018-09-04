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
    func upload(image:UIImage,completion:@escaping (Photo?) -> Void){
        let url = URL(string: API.upload.url)  /* your API url */
            
            let headers: HTTPHeaders = [
                /* "Authorization": "your_access_token",  in case you need authorization header */
                "Content-type": "multipart/form-data"
            ]
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                if let data:Data = UIImagePNGRepresentation(image) {
                    // Handle operations with data here...
                    multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")

                }
                
            }, usingThreshold: UInt64.init(), to: url!, method: .post, headers: headers) { (result) in
                switch result{
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print("Succesfully uploaded")
      print(response.description)
                        guard let data = response.data else { return }
                        let backToString = String(data: data, encoding: String.Encoding.utf8)
                        print(backToString ?? "backToString")
                        do {
                            let decoder = JSONDecoder()
                            let photo = try decoder.decode(Photo.self, from: data)
                            print(photo)
                            completion(photo)

                        } catch let err {
                            print("Err", err)
                            completion(nil)
                        }
                    }
                case .failure(let error):
                    print("Error in upload: \(error.localizedDescription)")
                    //onError?(error)
                    completion(nil)

                }
            }
        }
        
    }

