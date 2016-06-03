//
//  AdPhotosPageViewController.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import UIKit

class AdPhotosPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate  {
    let numberOfViews = 3
    
    var pageIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self;
        self.view.layer.backgroundColor = UIColor.whiteColor().CGColor
        setViewControllers([self.viewControllerAtIndex(0) as AdPhotosViewController], direction: .Forward, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func viewControllerAtIndex(index: Int) -> AdPhotosViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AdDetailViewController") as! AdPhotosViewController
        viewController.pageIndex = index
        
        self.pageIndex = index
        viewController.imageView.image = UIImage(named: "\(index+1)")
        return viewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! AdPhotosViewController).pageIndex
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
        case numberOfViews:
            return nil
        case NSNotFound:
            fatalError("NSNotFound. Should crash.")
        default:
            
            return viewControllerAtIndex(index)
        }
        
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return numberOfViews
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
