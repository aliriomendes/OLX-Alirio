//
//  AdDetailViewController.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import UIKit

class AdDetailViewController: UIViewController {
    var pageIndex: Int!
    var ad:Ad!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateDescriptionLabel: UILabel!
    
    @IBOutlet weak var lacationContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem!.title = ""
        
        let headerImageTGRecognizer = UITapGestureRecognizer(target:self, action:#selector(AdDetailViewController.headerImageTapped(_:)))
        let lacationContainerTGRecognizer = UITapGestureRecognizer(target:self, action:#selector(AdDetailViewController.lacationContainerTapped(_:)))

        headerImageView.userInteractionEnabled = true
        headerImageView.addGestureRecognizer(headerImageTGRecognizer)
        
        lacationContainerView.userInteractionEnabled = true
        lacationContainerView.addGestureRecognizer(lacationContainerTGRecognizer)
    }
    override func viewWillAppear(animated: Bool) {
        self.updateUI()
    }
    
    func updateUI(){
        if let firstPhoto = ad?.photos.first {
            headerImageView.downloadedFrom(link: firstPhoto.url)
        }
        priceLabel.text = self.ad!.list_label
        titleLabel.text = self.ad!.title
        dateDescriptionLabel.text = self.ad!.created
    }
    
    func headerImageTapped(img: AnyObject){
        self.performSegueWithIdentifier(Storyboard.PhotosPageSegueIdentifier, sender: self.ad)
    }
    
    func lacationContainerTapped(img: AnyObject){
        self.performSegueWithIdentifier(Storyboard.LocationViewSegueIdentifier, sender: self.ad)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.PhotosPageSegueIdentifier {
            let viewController = segue.destinationViewController as! AdPhotosPageViewController
            let ad = sender as! Ad
            viewController.photos = ad.photos
        }else if segue.identifier == Storyboard.LocationViewSegueIdentifier {
            let viewController = segue.destinationViewController as! AdLocationViewController
            let ad = sender as! Ad
            viewController.ad = ad
        }
    }
    
    
    
}
