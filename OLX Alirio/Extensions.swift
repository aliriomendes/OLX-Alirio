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
    func downloadedFrom(link:String) {
        guard
            let url = URL(string: link)
            else {return}
        
        URLSession.shared().dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? HTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async { () -> Void in
                self.image = image
            }
        }).resume()
    }
}
