//
//  AdDetailPageViewController.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import UIKit

class AdDetailPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var ads:Ads!
    var indexPath:NSIndexPath!
    var pageIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self;
        self.view.layer.backgroundColor = UIColor.whiteColor().CGColor
        setViewControllers([self.viewControllerAtIndex(indexPath.row)], direction: .Forward, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func viewControllerAtIndex(index: Int) -> AdDetailViewController {
        let viewController = UIStoryboard(name: Storyboard.StoryboardIdentifier, bundle: nil).instantiateViewControllerWithIdentifier(Storyboard.AdDetailViewIdentifier) as! AdDetailViewController
        viewController.pageIndex = index
        
        self.pageIndex = index
        viewController.ad = ads.adForItemAtIndexPath(NSIndexPath(forItem: index, inSection: indexPath.section))
        
        return viewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! AdDetailViewController).pageIndex
        index = index - 1
        
        switch index {
        case -1:
            return nil
        case NSNotFound:
            fatalError("NSNotFound. Should crash.")
        default:
            return viewControllerAtIndex(index)
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! AdDetailViewController).pageIndex
        index = index + 1
        
        switch index {
        case ads.numberOfAds:
            return nil
        case NSNotFound:
            fatalError("NSNotFound. Should crash.")
        default:
            return viewControllerAtIndex(index)
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return  ads.numberOfAds
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return -1
    }
}
