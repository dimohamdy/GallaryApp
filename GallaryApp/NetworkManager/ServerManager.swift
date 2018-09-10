//
//  ServerManager.swift
//  GallaryApp
//
//  Created by BinaryBoy on 9/3/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import Alamofire

class ServerManager {
    static let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")

    static func startNetworkReachabilityObserver() {
        
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                //print("⚠ The network is not reachable")
                Banner.shared.showAlert("⚠ The network is not reachable")
            case .unknown : break
                //print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                //print("The network is reachable over the WiFi connection")
                fallthrough
            case .reachable(.wwan):
                //print("The network is reachable over the WWAN connection")
                Banner.shared.hide(bannerType: .internet)
            }
        }
        
        // start listening
        reachabilityManager?.startListening()
    }
    
    static func getPhotos(completion:@escaping ([Photo]?) -> Void){
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
    static func upload(image:UIImage,completion:@escaping (Photo?) -> Void){
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

