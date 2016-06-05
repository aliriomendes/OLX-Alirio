//
//  Photo.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 05/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import Foundation

class Photo: NSObject {
    var slot_id:Int
    var width:Int
    var height:Int
    var url:String
    
    init(slot_id:Int, width:Int, height:Int) {
        self.slot_id = slot_id
        self.width = width
        self.height = height
        self.url = dummyPhotoUrls[Int(arc4random_uniform(UInt32(dummyPhotoUrls.count)))]
    }
    
}