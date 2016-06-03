//
//  AdDetailViewController.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import UIKit

class AdDetailViewController: UIViewController {
    var pageIndex: Int!
    var ad:Ad?{
        didSet{
            self.updateUI()
        }
    }
    @IBOutlet weak var backgroudImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func updateUI(){
        
    }
    
}
