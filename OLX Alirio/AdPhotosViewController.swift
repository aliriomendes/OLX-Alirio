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
            if view.isKind(UIScrollView) {
                view.frame = UIScreen.main().bounds
            } else if view.isKind(UIPageControl) {
                view.backgroundColor = UIColor.clear()
            }
        }
        self.imageView.downloadedFrom(link: photo.url)
    }
}
