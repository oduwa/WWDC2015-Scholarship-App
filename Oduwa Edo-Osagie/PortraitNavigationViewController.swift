//
//  PortraitNavigationViewController.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 19/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class PortraitNavigationViewController: UINavigationController {

    var canRotateToAllOrientations : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        canRotateToAllOrientations = false;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true;
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait;
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue);
    }

    

}
