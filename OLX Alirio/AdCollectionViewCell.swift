//
//  AdCollectionViewCell.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import UIKit

class AdCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    var ad:Ad? {
        didSet{
            self.updateUI()
        }
    }
    func updateUI()  {
        self.title.text = ad?.title
        self.price.text = ad?.list_label
    }
}
