//
//  AdFactory.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 08/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import Foundation
import SwiftyJSON

public class AdFactory: NSObject {
    
    enum AdFactoryError: ErrorProtocol {
        case itemsWithOutData
        case itemWithOutData
        case itemWithOutTitle
        case itemWithOutId
        case itemWithOutDescription
        case itemWithOutPrice
        case itemWithOutDisplayPrice
    }
    
    
    public static func convert(_ responseBody : AnyObject?) throws -> [Ad]{
        var adList = [Ad]()
        
        if responseBody == nil {
            throw Debug.Throw("Response body is null", error:AdFactoryError.itemsWithOutData)
        }
        
        if let body = responseBody as? Dictionary<String, AnyObject> {
            if let data = body["data"] as? [Dictionary<String, AnyObject>] {
                if data.count == 0 {
                    throw Debug.Throw("error array empty", error:AdFactoryError.itemsWithOutData)
                }
                
                for object in data {
                    do {
                        let item = try self.createItem(object)
                        if item != nil {
                            adList.append(item!)
                        }
                    } catch {
                        Debug.Log("Exception Block", info: object)
                    }
                }
                
            } else {
                throw Debug.Throw("Items List error", error:AdFactoryError.itemsWithOutData)
            }
        } else {
            throw Debug.Throw("Object not valid", error:AdFactoryError.itemsWithOutData)
            
        }
        
        if adList.count == 0 {
            throw Debug.Throw("Item List is empty", error:AdFactoryError.itemsWithOutData)
            
        }
        
        return adList
    }
    
    
    public static func createItem( _ data : Dictionary<String, AnyObject>) throws -> Ad? {
        if let title = data["title"] as? String {
            
            if let id = data["id"] as? String {
                
                    
                    if let price = data["price"] as? Dictionary<String, AnyObject> {
                        
                            if let url = price["url"] as? String{
                                
                                if let photos = price["photos"] as? JSON{
                                    
                                    if let list_label = price["list_label"] as? String{
                                        
                                        return Ad(id: id, url: url, title: title, list_label: list_label, photosJson: photos)
                                        
                                    } else {
                                        throw Debug.Throw("Item without value of price", error:AdFactoryError.itemWithOutDisplayPrice)
                                    }
                                   
                                
                            } else {
                                throw Debug.Throw("Item without value of price", error:AdFactoryError.itemWithOutDisplayPrice)
                            }
                            
                        } else {
                            throw Debug.Throw("Item without value of price", error:AdFactoryError.itemWithOutDisplayPrice)
                        }
                        
                    } else {
                        throw Debug.Throw("Item without Price", error:AdFactoryError.itemWithOutPrice)
                    }
                
            } else {
                throw Debug.Throw("Item without Id", error:AdFactoryError.itemWithOutId)
            }
            
        } else {
            throw Debug.Throw("Item without title", error:AdFactoryError.itemWithOutTitle)
        }        
    }
}
