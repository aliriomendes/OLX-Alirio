//
//  AdPhotosViewController.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import UIKit

class AdPhotosViewController: UIViewController {
    var pageIndex: Int!
    var photo:Photo!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI(){
        for view in self.view.subviews {
            if view.isKindOfClass(UIScrollView) {
                view.frame = UIScreen.mainScreen().bounds
            } else if view.isKindOfClass(UIPageControl) {
                view.backgroundColor = UIColor.clearColor()
            }
        }
        self.imageView.downloadedFrom(link: photo.url)
    }
}
