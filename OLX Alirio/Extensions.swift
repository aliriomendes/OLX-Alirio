//
//  Extensions.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 04/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import Foundation
import SwiftyJSON

extension UIImageView {
    func downloadedFrom(link link:String) {
        guard
            let url = NSURL(string: link)
            else {return}
        
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.image = image
            }
        }).resume()
    }
}