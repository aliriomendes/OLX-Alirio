//
//  Add.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import Foundation
import SwiftyJSON

class Ad: NSObject {
    var id:String
    var url:String
    var preview_url:String?
    var title:String
    var created:String?
    var age:Int?
    var adDescription:String?
    var highlighted:Bool?
    var urgent:Bool?
    var topAd:Bool?
    var promotion_section:Bool?
    var category_id: Int?
    var params: Dictionary<String,String>?
    var subtitle: Dictionary<String,String>?
    var business:Bool?
    var hide_user_ads_button:Bool?
    var status:String?
    var campaignSource:String?
    var header:String?
    var header_type:String?
    var has_email:Bool?
    var is_price_negotiable:Bool?
    var map_zoom:Int?
    var map_lat:Double?
    var map_lon:Double?
    var map_radius:Double?
    var map_show_detailed:Bool?
    var map_location:String?
    var city_label:String?
    var person:String?
    var user_label:String?
    var user_ads_id:String?
    var user_id:String?
    var numeric_user_id:Int64?
    var user_ads_url:String?
    var list_label:String
    var list_label_ad:String?
    var photos:Photos

    var chat_options:Bool?
    init(id:String, url:String, title:String, list_label:String, photosJson:JSON) {
        self.id = id
        self.url = url
        self.list_label = list_label
        self.title = title
        self.photos = Photos(json: photosJson)
    }
}