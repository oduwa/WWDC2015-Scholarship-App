//
//  ScreenshotContentViewController.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 21/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class ScreenshotContentViewController: UIViewController {

    var pageIndex : Int!;
    var pageCount : Int!;
    var imageName = "";
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imageView.image = UIImage(named: imageName);
        pageControl.numberOfPages = pageCount;
        pageControl.currentPage = pageIndex;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: Status Bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
}
