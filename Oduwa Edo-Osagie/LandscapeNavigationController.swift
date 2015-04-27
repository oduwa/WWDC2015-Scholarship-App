//
//  LandscapeNavigationController.swift
//  OduwaEdo-Osagie
//
//  Created by Odie Edo-Osagie on 16/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class LandscapeNavigationController: UINavigationController {
   
    var canRotateToAllOrientations : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.canRotateToAllOrientations = true;
    }
    
    override func shouldAutorotate() -> Bool {
        return true;
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.LandscapeRight;
    }
    
    override func supportedInterfaceOrientations() -> Int {
        //return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue);
        return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue);
    }
    

    
}
