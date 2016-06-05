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
    @IBOutlet weak var titleContainerView: UIView!
    
    var delegate:AdCollectionViewCellDelegate?
    var ad:Ad? {
        didSet{
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        self.titleContainerView.layer.shadowColor = UIColor.grayColor().CGColor
        self.titleContainerView.layer.shadowOpacity = 0.5
        self.titleContainerView.layer.shadowOffset = CGSizeMake(-2.0, 2.0)
    }
    
    func updateUI()  {
        self.title.text = ad?.title
        self.price.text = ad?.list_label
        if let firstPhoto = ad?.photos.first {
            thumbnail.downloadedFrom(link: firstPhoto.url)
        }
    }
    @IBAction func shareButtonPressed(sender: AnyObject) {
           self.delegate!.shareButtonPressed(self)
    }
}

protocol AdCollectionViewCellDelegate{
    func shareButtonPressed(sender: AdCollectionViewCell)
}

