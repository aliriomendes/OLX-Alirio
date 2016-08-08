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
        self.setViewControllers([self.viewControllerAtIndex(0) as AdPhotosViewController], direction: .forward, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func viewControllerAtIndex(_ index: Int) -> AdPhotosViewController {
        let viewController = UIStoryboard(name: Storyboard.StoryboardIdentifier, bundle: nil).instantiateViewController(withIdentifier: Storyboard.AdPhotosViewIdentifier) as! AdPhotosViewController
        viewController.pageIndex = index
        
        viewController.photo = self.photos.photoAtIndex(index)
        self.pageIndex = index
        return viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! AdPhotosViewController).pageIndex
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
        var index = (viewController as! AdPhotosViewController).pageIndex
        index = index! + 1
        
        switch index {
        case photos.numberOfPhotos!:
            return nil
        case NSNotFound!:
            fatalError("NSNotFound. Should crash.")
        default:
            return viewControllerAtIndex(index!)
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.numberOfPhotos
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
