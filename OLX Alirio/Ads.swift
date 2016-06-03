//
//  Adds.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Ads: NSObject {
    private var ads = [Ad]()
    var delegate:AdsDelegate?
    
    var numberOfAds:Int {
        return ads.count
    }
    override init() {
        super.init()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.ads = self.getAdsFromServer()
            dispatch_async(dispatch_get_main_queue(), {
                print(self.numberOfAds)
                self.delegate?.adsUpdated()
            });
        });
    }
    
    func deleteItemAtIndexPath(indexPaths:[NSIndexPath]){
        var indexes = [Int]()
        indexPaths.forEach { (indexPath) in
            indexes.append(indexPath.row)
        }
        var leftAds = [Ad]()
        for(index, add) in ads.enumerate(){
            if !indexes.contains(index) {
                leftAds.append(add)
            }
        }
        ads = leftAds
    }
    func adForItemAtIndexPath(indexPath:NSIndexPath) -> Ad {
        if indexPath.section > 0 {
            let sectionAds = self.adsForSection(indexPath.section)
            return sectionAds[indexPath.row]
        }else {
            return self.ads[indexPath.row]
        }
    }
    
    func adsForSection(section:Int) -> [Ad] {
        //MARK: - TODO
        return []
    }
    
    func getAdsFromServer() -> [Ad]{
        var newAdds = [Ad]()
        let url = "https://olx.pt/i2/ads/?json=1&search"
        let parameters = ["category_id": 25]
        
        let semaphore = dispatch_semaphore_create(0);
        
        Alamofire.request(.GET, url, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let adsArray = json["ads"].arrayValue
                    adsArray.forEach({ (ad) in
                        let ad = Ad(id: ad["id"].stringValue, url: ad["url"].stringValue, title:ad["title"].stringValue,list_label: ad["list_label"].stringValue)
                        newAdds.append(ad)
                    })
                }
            case .Failure(let error):
                print(error)
            }
             dispatch_semaphore_signal(semaphore);
        }
        while dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW) != 0 {
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 10))
        }
        return newAdds
    }
}

protocol AdsDelegate{
    func adsUpdated()
}