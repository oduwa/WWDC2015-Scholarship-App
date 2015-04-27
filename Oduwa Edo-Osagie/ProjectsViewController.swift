//
//  ProjectsViewController.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 20/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController!;
    var backgroundImages = ["syren_blur", "jive_blur", "animehub_blur", "naruto_blur.jpg", /*"nomtek3_blur",*/ "realvnc_blur"];
    var tvBackgroundImages = ["syren_tv_bg", "jive_blur", "animehub_blur", "naruto_blur.jpg", /*"nomtek3_blur",*/ "realvnc_blur"];
    var iconImages = ["syren", "jive", "animehub", "naruto.jpg",/* "nomtek3",*/ "realvnc"];
    var projectNames = ["Syren", "Jive", "AnimeHub", "Naruto",/* "NOMTEK",*/ "Real VNC"];
    var projectTypeArray = ["app", "app", "app", "app",/* "internship",*/ "internship"];
    var projectDownloadLinks = ["", "https://itunes.apple.com/us/app/jive-for-ios/id911948088?mt=8", "https://itunes.apple.com/us/app/animehub-an-anime-fan-haven/id882620151?mt=8&ign-mpt=uo%3D4", "", "https://itunes.apple.com/us/app/vnc-viewer/id352019548?mt=8"];
    
    var syrenDescription = "Syren is an app that I made during the UEA Mobile App Challenge - a hackathon that was hosted at my university. It won me first place in the competition.\n\nIt allows users to compile old-school \"mixtapes\" and share them with their friends as well as play them.\n\nIt is not yet on the App Store as I am currently in the process adding a \"special feature\" to the app before launching it, so keep your eyes peeled!"
    
    var jiveDescription = "Jive is a music discovery app. It allows the user to listen to music on the app and learns their tastes. It can then suggest new artists and songs for the user to listen to. It also allows users to buy albums they've discoverd on the app from iTunes.\n\nIn addition to this, users can use the app to learn about upcoming concerts around them.\n\nIt also allows users to keep up to date with the music world with a news feed and album reviews. It then sends push notifications whenever anything new comes up."
    
    var animehubDescription = "I really like anime and manga (Japanese animations and comics) and had used some manga reader apps but I thought it would be better if I could also watch anime and do other things with the app - in essence, an ultimate app for the anime fan. Unfortunately, it didn't exist yet so I decided to make it!\n\nAnimeHub is a handy tool that allows you to keep up with and enjoy anime and manga. It provides users with the latest anime news (aggregated from various sources) with push notifications. It also allows users to watch anime episodes and download/read manga chapters.\n\n It uses Core Data syncing so users can access their content from all their devices."
    
    var narutoDescription = "This was my first attempt at mobile game development. I created an action platformer game based around the popular Naruto franchise using SpriteKit. It was very fun to build as I found SpriteKit very fluid and easy to work with.\n\nIt is not on the App Store because I don't have any rights to the Naruto franchise and do not want to infringe on its copyright."
    
    var realVNCDescription = "RealVNC is a company based in Cambridge that I am interning with. They are the inventors of Virtual Network Computing (VNC) protocol and the Remote Frame Buffer (RFB) protocol which are both used for remote computing.\n\nI am involved in creating remote access iOS apps with them."
    
    var screenshots = [["syren1", "syren2", "syren3", "syren4"],
        ["jive1", "jive2", "jive3", "jive4"],
        ["animehub1", "animehub2", "animehub3", "animehub4"],
        ["naruto1", "naruto2", "naruto3", "naruto4"],
        ["realvnc1.jpg", "realvnc2.jpg", "realvnc3.jpg", "realvnc4.jpg"]];
    
    var projectDescriptions = ["", "", "", "", "", ""];
    var mirroredWindow : UIWindow!
    var mirroredScreen : UIScreen!
    var mirroredView : UIView!
    var isExternalScreenConnected = false;

    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Nav Bar */
        self.navigationController?.navigationBarHidden = true;
        
        /* iVar Initialization */
        projectDescriptions = [syrenDescription, jiveDescription, animehubDescription, narutoDescription, realVNCDescription];
        
        /* Initialize page view controller */
        createPageViewController();
        self.view.layoutIfNeeded()
        
        /* Register for screen notifications */
        var center : NSNotificationCenter = NSNotificationCenter.defaultCenter();
        center.addObserver(self, selector: Selector("screenDidConnect:"), name: UIScreenDidConnectNotification, object: nil);
        center.addObserver(self, selector: Selector("screenDidDisconnect:"), name: UIScreenDidDisconnectNotification, object: nil);
        center.addObserver(self, selector: Selector("screenModeDidChange:"), name: UIScreenModeDidChangeNotification, object: nil);
        
        self.checkForExistingExternalScreenAndInitialize()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self);
        if(self.mirroredWindow != nil){
            self.clearScreen(self.mirroredWindow.bounds);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: AIRPLAY
    
    func checkForExistingExternalScreenAndInitialize() -> Bool {
        if(UIScreen.screens().count > 1){
            var mainScreen = UIScreen.mainScreen();
            for aScreen in UIScreen.screens() {
                if (aScreen as! UIScreen != mainScreen) {
                    // Found an external screen. Initialize it !
                    self.initializeWindowForScreen(aScreen as! UIScreen);
                    return true;
                }
            }
            
            return false;
        }
        else{
            return false;
        }
    }
    
    func initializeWindowForScreen(screen: UIScreen){
        isExternalScreenConnected = true;
        self.mirroredScreen = screen;
        
        // Find max resolution
        var max : CGSize = CGSizeZero;
        var maxScreenMode : UIScreenMode!;
        
        for current in self.mirroredScreen.availableModes {
            if (maxScreenMode == nil || current.size.height > max.height || current.size.width > max.width) {
                max = current.size;
                maxScreenMode = current as! UIScreenMode;
            }
        }
        
        self.mirroredScreen.currentMode = maxScreenMode;
        
        // Create 2nd window
        var screenBounds = self.mirroredScreen.bounds;
        self.mirroredWindow = UIWindow(frame: screenBounds);
        self.mirroredWindow.screen = self.mirroredScreen;
        self.mirroredWindow.backgroundColor = UIColor.whiteColor();
        self.mirroredWindow.layer.contentsGravity = kCAGravityResizeAspect;
        
        self.displayViewOnScreen(screenBounds);
    
        // Show the window.
        self.mirroredWindow.hidden = false;
    }
    
    func screenDidConnect(notification: NSNotification){
        isExternalScreenConnected = true;
        var screen : UIScreen = notification.object as! UIScreen;
        self.initializeWindowForScreen(screen);
    }
    
    func screenDidDisconnect(notification: NSNotification){
        isExternalScreenConnected = false
        self.disableMirroringOnCurrentScreen();
    }
    
    func screenModeDidChange(notification: NSNotification){
        var screen : UIScreen = notification.object as! UIScreen;
        self.disableMirroringOnCurrentScreen();
        self.initializeWindowForScreen(screen);
        isExternalScreenConnected = true;
    }
    
    func disableMirroringOnCurrentScreen(){
        self.mirroredView.removeFromSuperview();
        self.mirroredView = nil;
        self.mirroredScreen = nil;
        self.mirroredWindow = nil;
    }
    
    func clearScreen(withBounds: CGRect){
        self.mirroredView.removeFromSuperview();
        
        // Create view to display
        self.mirroredView = UIView(frame: withBounds);
        self.mirroredView.backgroundColor = UIColor.whiteColor();
        self.mirroredWindow.addSubview(mirroredView);
        
        // Background image view
        var splash : SplashView = SplashView.instanceFromNib() as! SplashView;
        splash.frame = withBounds;
        splash.setup();
        self.mirroredView.addSubview(splash);
    }
    
    func displayViewOnScreen(withBounds: CGRect){
        // Clear window
        if(self.mirroredView != nil){
            self.mirroredView.removeFromSuperview();
        }

        // Create view to display
        self.mirroredView = UIView(frame: withBounds);
        self.mirroredView.backgroundColor = UIColor.whiteColor();
        self.mirroredWindow.addSubview(mirroredView);
        
        // Background image view
        var bgImage = UIImage(named: "woods_blur.jpg");
        var bgImageView = UIImageView(frame: withBounds);
        bgImageView.contentMode = UIViewContentMode.ScaleAspectFill;
        bgImageView.image = bgImage;
        self.mirroredView.addSubview(bgImageView);
        var filterView = UIView(frame: withBounds);
        filterView.backgroundColor = UIColor.whiteColor();
        filterView.alpha = 0.4;
        self.mirroredView.addSubview(filterView);
        
        // Content View
        var imageGroup : ImageGroup = ImageGroup.instanceFromNib() as! ImageGroup;
        imageGroup.frame = withBounds;
        imageGroup.setup();
        imageGroup.topLeft.image = UIImage(named: screenshots[SwiftAppUtils.sharedInstance.currentProjectPageIndex][0]);
        imageGroup.topRight.image = UIImage(named: screenshots[SwiftAppUtils.sharedInstance.currentProjectPageIndex][1]);
        imageGroup.bottomLeft.image = UIImage(named: screenshots[SwiftAppUtils.sharedInstance.currentProjectPageIndex][2]);
        imageGroup.bottomRight.image = UIImage(named: screenshots[SwiftAppUtils.sharedInstance.currentProjectPageIndex][3]);
        self.mirroredView.addSubview(imageGroup);

    }
    
    // MARK: PAGE VIEW

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        /* Get current Content View Controller */
        let contentController = viewController as! PageContentViewController;

        if contentController.pageIndex > 0 {
            return getContentController(contentController.pageIndex-1);
        }
        
        /* If first content controller, return nil */
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        /* Get current Content View Controller */
        let contentController = viewController as! PageContentViewController;
        
        if contentController.pageIndex < backgroundImages.count {
            return getContentController(contentController.pageIndex+1);
        }
        
        /* If first content controller, return nil */
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        if(completed){
            /* Update Page Control to show current page index */
            //let previousController: PageContentViewController = previousViewControllers[0] as PageContentViewController;
            let currentViewController : PageContentViewController = pageViewController.viewControllers[0] as! PageContentViewController;
            pageControl.currentPage = currentViewController.pageIndex
            SwiftAppUtils.sharedInstance.currentProjectPageIndex = pageControl.currentPage;
            
            /* Update external screen */
            if(isExternalScreenConnected == true){
                displayViewOnScreen(self.mirroredWindow.bounds);
            }
        }
    }
    
    
    /*
    // MARK: - PAGE VIEW : Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return images.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    */
    
    
    // MARK: HELPERS
    
    private func createPageViewController() {
        let pageController : UIPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pageViewController") as! UIPageViewController;
        pageController.dataSource = self;
        pageController.delegate = self;
        
        if (backgroundImages.count > 0) {
            let firstController = getContentController(0)!;
            let startingViewControllers: NSArray = [firstController];
            pageController.setViewControllers(startingViewControllers as! [PageContentViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil);
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func getContentController(itemIndex: Int) -> PageContentViewController? {

        if (itemIndex < backgroundImages.count) {
            let pageContentController = self.storyboard!.instantiateViewControllerWithIdentifier("pageContentController") as! PageContentViewController;
            pageContentController.pageIndex = itemIndex;
            pageContentController.bgImageName = backgroundImages[itemIndex];
            pageContentController.iconImageName = iconImages[itemIndex];
            pageContentController.projectName = projectNames[itemIndex];
            pageContentController.projectType = projectTypeArray[itemIndex];
            pageContentController.downloadLink = projectDownloadLinks[itemIndex];
            pageContentController.projectDescription = projectDescriptions[itemIndex];
            return pageContentController;
        }
        
        return nil;
    }
    
    
    // MARK: Selectors
    
    func backButtonPressed(){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    // MARK: Status Bar
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    

}
