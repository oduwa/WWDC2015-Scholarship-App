//
//  ScreenshotViewController.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 21/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class ScreenshotViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController!;
    
    var jiveScreens = ["jive1", "jive2", "jive3", "jive4"];
    var syrenScreens = ["jive1", "jive2", "jive3", "jive4"];
    var animehubScreens = ["jive1", "jive2", "jive3", "jive4"];
    var narutoScreens = ["jive1", "jive2", "jive3", "jive4"];
    var realVNCScreens = ["jive1", "jive2", "jive3", "jive4"];
    
    var screenshots = [["syren1", "syren2", "syren3", "syren4"],
        ["jive1", "jive2", "jive3", "jive4"],
        ["animehub1", "animehub2", "animehub3", "animehub4"],
        ["naruto1", "naruto2", "naruto3", "naruto4"],
        ["realvnc1.jpg", "realvnc2.jpg", "realvnc3.jpg", "realvnc4.jpg"]];
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Nav Bar */
        self.navigationController?.navigationBarHidden = true;
        
        /* Initialize page view controller */
        createPageViewController();
        self.view.layoutIfNeeded();
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: PAGE VIEW DELEGATE
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        /* Get current Content View Controller */
        let contentController = viewController as! ScreenshotContentViewController;
        
        if contentController.pageIndex > 0 {
            return getContentController(contentController.pageIndex-1);
        }
        
        /* If first content controller, return nil */
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        /* Get current Content View Controller */
        let contentController = viewController as! ScreenshotContentViewController;
        
        if contentController.pageIndex < screenshots[SwiftAppUtils.sharedInstance.currentProjectPageIndex].count {
            return getContentController(contentController.pageIndex+1);
        }
        
        /* If first content controller, return nil */
        return nil
    }

    private func createPageViewController() {
        let pageController : UIPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pageViewController") as! UIPageViewController;
        pageController.dataSource = self;
        pageController.delegate = self;
        
        if (screenshots[SwiftAppUtils.sharedInstance.currentProjectPageIndex].count > 0) {
            let firstController = getContentController(0)!;
            let startingViewControllers: NSArray = [firstController];
            pageController.setViewControllers(startingViewControllers as! [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil);
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func getContentController(itemIndex: Int) -> ScreenshotContentViewController? {
        
        if (itemIndex < screenshots[SwiftAppUtils.sharedInstance.currentProjectPageIndex].count) {
            let pageContentController = self.storyboard!.instantiateViewControllerWithIdentifier("screenshotContentViewController") as! ScreenshotContentViewController;
            pageContentController.pageIndex = itemIndex;
            //println(SwiftAppUtils.sharedInstance.currentProjectPageIndex)
            //println(itemIndex)
            pageContentController.imageName = screenshots[SwiftAppUtils.sharedInstance.currentProjectPageIndex][itemIndex];
            pageContentController.pageCount = screenshots[SwiftAppUtils.sharedInstance.currentProjectPageIndex].count;
            return pageContentController;
        }
        
        return nil;
    }
    
    // MARK: Status Bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}





