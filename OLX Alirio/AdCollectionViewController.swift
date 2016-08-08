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
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true;
        self.navigationController!.navigationBar.topItem!.title = ""
        
        self.setupCollectionView()
    }
    func setupCollectionView(){
        if UIDevice.current().orientation == .portrait && UIDevice.current().userInterfaceIdiom == .phone {
            self.numberOfItemsPerRow = 1.0
        }
        else if (UIDevice.current().orientation == .landscapeLeft || UIDevice.current().orientation == .landscapeRight)
                && UIDevice.current().userInterfaceIdiom == .pad {
            self.numberOfItemsPerRow = 3.0
        }else{
            self.numberOfItemsPerRow = 2.0
        }
        self.totalPading = 8 * (self.numberOfItemsPerRow + 1)
        self.cellWidth = (collectionView!.frame.width - totalPading)/numberOfItemsPerRow
        self.cellHeight = self.cellWidth * 0.66
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height:cellHeight)
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        setupCollectionView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ads.numberOfAds
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell( withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! AdCollectionViewCell

        cell.ad = ads.adForItemAtIndexPath(indexPath)
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    func adsUpdated() {
        collectionView?.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.CellDetailIdentifier {
            let viewController = segue.destinationViewController as! AdDetailPageViewController
            
            viewController.ads = self.ads
            viewController.indexPath = (sender as! AdCollectionViewCell).indexPath
        }
    }
    
    func shareButtonPressed(_ sender: AdCollectionViewCell) {
        let ad =  sender.ad!
        let url = ad.url
        print(url)
        let messageStr:String  = ad.title
        
        let shareItems:Array = [messageStr, url]
        let activityController = UIActivityViewController(activityItems:shareItems, applicationActivities: nil)
        if UIDevice.current().userInterfaceIdiom == .pad {
            activityController.popoverPresentationController?.sourceView = self.view
        }
        self.present(activityController, animated: true,completion: nil)
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == (ads.numberOfAds-1) {
            ads.loadMoreFromServer()
        }
    }
}       

