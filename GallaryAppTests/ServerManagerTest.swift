//
//  ServerManagerTest.swift
//  GallaryAppTests
//
//  Created by BinaryBoy on 9/4/18.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import Quick
import Nimble

@testable import GallaryApp

class ServerManagerTest: QuickSpec {
    var server:ServerManager!
    
    override func spec() {
        
        describe("ServerManager") {
                        beforeEach {
                            self.server = ServerManager()            
                        }
                        context("Test number of photos from gallary API"){
                            it("expect get photos not empty array"){
                                self.server.getPhotos(completion: { photos in
                                    expect(photos?.count)  > 0
                                })
            
                            }
                        }
            
            
            
            context("Test upload image  API"){
                it("expect get photo object after upload"){
                    
                    waitUntil(timeout: 10, action: { done in
                        self.server.upload(image: #imageLiteral(resourceName: "close"), completion: { photo in
                            print(photo ?? "Emoty")
                            expect(photo).toNot(beNil());
                            done()
                            
                        })
                    })
                    
                }
            }
            
    }
    }
}
