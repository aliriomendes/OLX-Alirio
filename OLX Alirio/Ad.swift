//
//  Add.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import Foundation

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
    //"params": [],
    //"subtitle": [],
    var business:Bool?
    var hide_user_ads_button:Bool?
    var status:String?
    //var campaignSource: CampaignSource,
    var header:String?
    var header_type:String?
    var has_email:Bool?
    var is_price_negotiable:Bool?
    var map_zoom:Int?
    var map_lat:Double?
    var map_lon:Double?
    var map_radius:Int?
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
//    "photos": {
//				"riak_ring": 1,
//				"riak_key": 874783235,
//				"riak_rev": 0,
//				"data": [
//    {
//    "slot_id": 1,
//    "w": 740,
//    "h": 700
//    }
//				]
//    },
    var chat_options:Bool?
    init(id:String, url:String, title:String, list_label:String) {
        self.id = id
        self.url = url
        self.list_label = list_label
        self.title = title
    }
}