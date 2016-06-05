//
//  AddCollectionViewController.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import UIKit

class AdCollectionViewController: UICollectionViewController, AdsDelegate, AdCollectionViewCellDelegate {
    //data source
    let ads = Ads()
    
    private var totalPading:CGFloat = 0.0
    private var numberOfItemsPerRow:CGFloat = 0.0
    private var cellHeight:CGFloat = 0.0
    private var cellWidth:CGFloat = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.ads.delegate = self
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true;
        self.navigationController!.navigationBar.topItem!.title = ""
        
        self.setupCollectionView()
    }
    func setupCollectionView(){
        if UIDevice.currentDevice().orientation == .Portrait && UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.numberOfItemsPerRow = 1.0
        }
        else if (UIDevice.currentDevice().orientation == .LandscapeLeft || UIDevice.currentDevice().orientation == .LandscapeRight)
                && UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.numberOfItemsPerRow = 3.0
        }else{
            self.numberOfItemsPerRow = 2.0
        }
        self.totalPading = 8 * (self.numberOfItemsPerRow + 1)
        self.cellWidth = (CGRectGetWidth(collectionView!.frame) - totalPading)/numberOfItemsPerRow
        self.cellHeight = self.cellWidth * 0.66
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height:cellHeight)
    }
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        setupCollectionView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ads.numberOfAds
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCellWithReuseIdentifier( Storyboard.CellIdentifier, forIndexPath: indexPath) as! AdCollectionViewCell
        let ad = ads.adForItemAtIndexPath(indexPath)
        cell.ad = ad
        cell.delegate = self
        return cell
    }
    func adsUpdated() {
        collectionView?.reloadData()
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(Storyboard.CellDetailIdentifier, sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.CellDetailIdentifier {
            let viewController = segue.destinationViewController as! AdDetailPageViewController
            
            viewController.ads = self.ads
            viewController.indexPath = sender as! NSIndexPath
        }
    }
    
    func shareButtonPressed(sender: AdCollectionViewCell) {
        let ad =  sender.ad!
        let url = ad.url
        print(url)
        let messageStr:String  = ad.title
        
        let shareItems:Array = [messageStr, url]
        let activityController = UIActivityViewController(activityItems:shareItems, applicationActivities: nil)
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            activityController.popoverPresentationController?.sourceView = self.view
        }
        self.presentViewController(activityController, animated: true,completion: nil)
    }
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == (ads.numberOfAds-1) {
            ads.loadMoreFromServer()
        }
    }
}       

