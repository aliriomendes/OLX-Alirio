//
//  Photos.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 05/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photos {
    private var photos = [Photo]()
    private var raikRing:String?
    private var raikKey:String?
    private var raikRev:String?
    var first:Photo?{
        get{
            return photos.count > 0 ? photos[0] : nil
        }
    }
    
    init(json:JSON){
        self.parsePhotosJson(json)
    }
    var numberOfPhotos:Int {
        return self.photos.count
    }
    
    func photoAtIndex(index:Int) -> Photo {
        return self.photos[index]
    }
    func parsePhotosJson(json:JSON){
        var newPhotos = [Photo]()
        self.raikRing = json["raik_ring"].stringValue
        self.raikKey = json["raik_key"].stringValue
        self.raikRev = json["raik_rev"].stringValue
        let data = json["data"].arrayValue
        
        data.forEach { (photoData) in
            let slotId = photoData["slot_id"].intValue
            let width = photoData["w"].intValue
            let height = photoData["h"].intValue
            let photo = Photo(slot_id: slotId, width: width, height: height)
            newPhotos.append(photo)
        }
        self.photos =  newPhotos
    }
}