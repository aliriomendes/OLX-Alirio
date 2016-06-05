//
//  AdPhotosPageViewController.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import UIKit

class AdPhotosPageViewController: UIPageViewController, UIPageViewControllerDataSource{
    var photos:Photos!
    var pageIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem!.title = ""
        self.dataSource = self
        self.setViewControllers([self.viewControllerAtIndex(0) as AdPhotosViewController], direction: .Forward, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func viewControllerAtIndex(index: Int) -> AdPhotosViewController {
        let viewController = UIStoryboard(name: Storyboard.StoryboardIdentifier, bundle: nil).instantiateViewControllerWithIdentifier(Storyboard.AdPhotosViewIdentifier) as! AdPhotosViewController
        viewController.pageIndex = index
        
        viewController.photo = self.photos.photoAtIndex(index)
        self.pageIndex = index
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
        var index = (viewController as! AdPhotosViewController).pageIndex
        index = index + 1
        
        switch index {
        case photos.numberOfPhotos:
            return nil
        case NSNotFound:
            fatalError("NSNotFound. Should crash.")
        default:
            return viewControllerAtIndex(index)
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return photos.numberOfPhotos
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
