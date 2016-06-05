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
    @IBOutlet weak var headerContainerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lacationContainerView: UIView!
    @IBOutlet weak var cityLocationLAbel: UILabel!
    
    
    @IBOutlet weak var adDescriptionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cityLocationLAbel.text = self.ad!.city_label
        adDescriptionLabel.text = self.ad!.adDescription
        adDescriptionLabel.sizeToFit()
        setupConstraintsView()
    }
    func setupConstraintsView(){
        if (UIDevice.currentDevice().orientation == .LandscapeLeft || UIDevice.currentDevice().orientation == .LandscapeRight)
            && UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            headerContainerHeightConstraint.constant = 250
        }else{
            headerContainerHeightConstraint.constant = 350
        }
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func headerImageTapped(sender: AnyObject){
        if ad.photos.numberOfPhotos > 0 {
            self.performSegueWithIdentifier(Storyboard.PhotosPageSegueIdentifier, sender: self.ad)
        }
    }
    
    @IBAction func lacationContainerTapped(sender: AnyObject){
        self.performSegueWithIdentifier(Storyboard.LocationViewSegueIdentifier, sender: self.ad)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        setupConstraintsView()
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
