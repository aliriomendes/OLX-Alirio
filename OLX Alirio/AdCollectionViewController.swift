//
//  AddCollectionViewController.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import UIKit

class AdCollectionViewController: UICollectionViewController, AdsDelegate {
    let cellIdentifier = "adCollectionCell"
    let cellDetailIdentifier = "adDetail"
    //data source
    let ads = Ads()
    private let leftAndRightPading:CGFloat = 20.0
    private let numberOfItemsPerRow:CGFloat = 3
    private let cellHeight:CGFloat = 30.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.ads.delegate = self
        self.setupCollectionView()
        print("viewDidLoad")
    }
    override func viewDidAppear(animated: Bool) {
        print("viewDidAppear")
    }
    func setupCollectionView(){
        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPading)/numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width*0.66)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.numberOfAds
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCellWithReuseIdentifier( cellIdentifier, forIndexPath: indexPath) as! AdCollectionViewCell
        let ad = ads.adForItemAtIndexPath(indexPath)
        cell.ad = ad
        return cell
    }
    func adsUpdated() {
        collectionView?.reloadData()
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let ad = ads.adForItemAtIndexPath(indexPath)
        self.performSegueWithIdentifier(cellDetailIdentifier, sender: ad)
    }
}       

