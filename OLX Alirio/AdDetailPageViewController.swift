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
    var indexPath:IndexPath!
    var pageIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self;
        self.view.layer.backgroundColor = UIColor.white().cgColor
        setViewControllers([self.viewControllerAtIndex(indexPath.row)], direction: .forward, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func viewControllerAtIndex(_ index: Int) -> AdDetailViewController {
        let viewController = UIStoryboard(name: Storyboard.StoryboardIdentifier, bundle: nil).instantiateViewController(withIdentifier: Storyboard.AdDetailViewIdentifier) as! AdDetailViewController
        viewController.pageIndex = index
        
        self.pageIndex = index
        viewController.ad = ads.adForItemAtIndexPath(IndexPath(item: index, section: indexPath.section))
        
        return viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! AdDetailViewController).pageIndex
        index = index! - 1
        
        switch index {
        case -1:
            return nil
        case NSNotFound!:
            fatalError("NSNotFound. Should crash.")
        default:
            return viewControllerAtIndex(index!)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! AdDetailViewController).pageIndex
        index = index! + 1
        
        switch index {
        case ads.numberOfAds!:
            return nil
        case NSNotFound!:
            fatalError("NSNotFound. Should crash.")
        default:
            return viewControllerAtIndex(index!)
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return  ads.numberOfAds
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return -1
    }
}
