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
    private let url = "https://olx.pt/i2/ads/?json=1&search"
    private let parameters = ["category_id": 25]
    private var nextPageUrl:String?
    private var totalAds:Int?
    var delegate:AdsDelegate?
    
    
    var numberOfAds:Int {
        return self.ads.count
    }
    override init() {
        super.init()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.ads = self.getAdsFromServer(self.url,parameters: self.parameters)
            dispatch_async(dispatch_get_main_queue(), {
                self.delegate?.adsUpdated()
            });
        });
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
    func loadMoreFromServer(){
        if  self.ads.count < self.totalAds {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.ads.appendContentsOf(  self.getAdsFromServer(self.nextPageUrl!) )
                dispatch_async(dispatch_get_main_queue(), {
                    self.delegate?.adsUpdated()
                });
            });
        }
    }

    func getAdsFromServer(url:String, parameters:Dictionary<String,AnyObject>? = nil) -> [Ad]{
        var newAds = [Ad]()
        let semaphore = dispatch_semaphore_create(0);
        
        Alamofire.request(.GET, url, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let adsArray = json["ads"].arrayValue
                    
                    self.nextPageUrl = json["next_page_url"].stringValue
                    self.totalAds = json["total_ads"].intValue
                    
                    adsArray.forEach({ (adJSON) in
                        newAds.append( self.parseAdFromJson(adJSON) )
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
        return newAds
    }
    
    func parseAdFromJson(adJSON:JSON) -> Ad{
        //print(adJSON)
        let id = adJSON["id"].stringValue
        let url = adJSON["url"].stringValue
        let title = adJSON["title"].stringValue
        let list_label = adJSON["list_label"].stringValue
        let photos = adJSON["photos"]
        
        let ad = Ad(id: id, url: url, title: title, list_label: list_label, photosJson: photos)
        ad.adDescription = adJSON["description"].stringValue
        ad.preview_url = adJSON["preview_url"].stringValue
        ad.created = adJSON["created"].stringValue
        ad.age = adJSON["age"].int
        ad.highlighted = adJSON["highlighted"].boolValue
        ad.urgent = adJSON["urgent"].boolValue
        ad.topAd = adJSON["topAd"].boolValue
        ad.promotion_section = adJSON["promotion_section"].boolValue
        ad.category_id = adJSON["description"].int
        ad.business = adJSON["business"].boolValue
        ad.hide_user_ads_button = adJSON["hide_user_ads_button"].boolValue
        ad.status = adJSON["status"].stringValue
        ad.header = adJSON["header"].stringValue
        ad.header_type = adJSON["header_type"].stringValue
        ad.has_email = adJSON["has_email"].boolValue
        ad.is_price_negotiable = adJSON["is_price_negotiable"].boolValue
        ad.map_zoom = adJSON["map_zoom"].int
        ad.map_lat = adJSON["map_lat"].doubleValue
        ad.map_lon = adJSON["map_lon"].doubleValue
        ad.map_radius = adJSON["map_radius"].doubleValue
        ad.map_show_detailed = adJSON["map_show_detailed"].boolValue
        ad.map_location = adJSON["map_location"].stringValue
        ad.city_label = adJSON["city_label"].stringValue
        ad.person = adJSON["person"].stringValue
        ad.user_label = adJSON["user_label"].stringValue
        ad.user_ads_id = adJSON["user_ads_id"].stringValue
        ad.numeric_user_id = adJSON["numeric_user_id"].int64Value
        ad.user_ads_url = adJSON["user_ads_url"].stringValue
        ad.list_label_ad = adJSON["list_label_ad"].stringValue
        ad.user_ads_url = adJSON["user_ads_url"].stringValue
        
        
        return ad
    }
}

protocol AdsDelegate{
    func adsUpdated()
}