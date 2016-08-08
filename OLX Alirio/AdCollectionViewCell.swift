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
    var indexPath:IndexPath?
    var delegate:AdCollectionViewCellDelegate?
    var ad:Ad? {
        didSet{
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        self.titleContainerView.layer.shadowColor = UIColor.gray().cgColor
        self.titleContainerView.layer.shadowOpacity = 0.5
        self.titleContainerView.layer.shadowOffset = CGSize(width: -2.0, height: 2.0)
    }
    
    func updateUI()  {
        self.title.text = ad?.title
        self.price.text = ad?.list_label
        if let firstPhoto = ad?.photos.first {
            thumbnail.downloadedFrom(link: firstPhoto.url)
        }
    }
    @IBAction func shareButtonPressed(_ sender: AnyObject) {
           self.delegate!.shareButtonPressed(self)
    }
}

protocol AdCollectionViewCellDelegate{
    func shareButtonPressed(_ sender: AdCollectionViewCell)
}

